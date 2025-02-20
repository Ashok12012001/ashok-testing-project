#include <ESPmDNS.h>
#include <PicoMQTT.h>
#include <esp_task_wdt.h>
#include <WiFi.h>
#include <Arduino.h>
#include <ros.h>
#include <std_msgs/String.h>

ros::NodeHandle nh;
std_msgs::String str_msg;
ros::Publisher chatter("esp_data", &str_msg);

#define WDT_TIMEOUT 30  // Increased Watchdog timeout to 30 seconds
#define SlaveCNT 5       

PicoMQTT::Server mqtt;
const char *ssid = "Project_AQM";
const char *password = "AQM##2220";

int slaveSTATE[SlaveCNT] = {0};
unsigned long lastUpdateTime[SlaveCNT] = {0};
const unsigned long timeoutInterval = 30000; 

unsigned long write_time = 0;
unsigned long last_write_time = 0;
int wait_time = 1000; 

TaskHandle_t mqttTaskHandle;

void setup() {
    Serial.begin(115200);
    Serial2.begin(115200);

    // **Fix Watchdog Initialization**
    if (!esp_task_wdt_status(NULL)) {  // Check if watchdog is already initialized
        esp_task_wdt_config_t wdt_config = {
            .timeout_ms = WDT_TIMEOUT * 1000,
            .idle_core_mask = 0,
            .trigger_panic = true
        };
        esp_task_wdt_init(&wdt_config);
    }
    esp_task_wdt_add(NULL);

    // WiFi Connection
    WiFi.begin(ssid, password);
    while (WiFi.status() != WL_CONNECTED) {
        delay(100);
        Serial2.print(".");
    }
    Serial2.println("\nConnected to Wi-Fi!");
    Serial2.println(WiFi.localIP());

    // Initialize ROS
    nh.initNode();
    nh.advertise(chatter);

    // Start mDNS
    if (!MDNS.begin("amr")) {
        Serial2.println("Error starting mDNS");
        return;
    }
    Serial2.println("mDNS started. You can access the ESP32 at amr.local");

    // MQTT Subscription Handling
    mqtt.subscribe("#", [](const char *topic, const char *payload) {
        Serial2.printf("Received message in topic '%s': %s\n", topic, payload);
        if (String(topic) == "SLstate") {
            int commaIndex = String(payload).indexOf(',');
            if (commaIndex != -1) {
                int save_ID = String(payload).substring(0, commaIndex).toInt();
                int slave_STATE = String(payload).substring(commaIndex + 1).toInt();
                
                if (save_ID > 0 && save_ID <= SlaveCNT) {
                    Serial2.println("Slave state updated");
                    slaveSTATE[save_ID - 1] = slave_STATE;
                    lastUpdateTime[save_ID - 1] = millis();
                }
            }
        }
    });

    // Start MQTT Broker
    mqtt.begin();

    // **Run MQTT & ROS Processing on Core 0**
    xTaskCreatePinnedToCore(
        mqttTask,       // Task function
        "MQTT Task",    // Task name
        10000,          // Stack size
        NULL,           // Task input parameter
        1,              // Task priority
        &mqttTaskHandle,// Task handle
        0               // Run on Core 0
    );
}

void loop() {
    esp_task_wdt_reset();  // Reset watchdog in main loop

    write_time = millis();
    if (write_time - last_write_time > wait_time) {
        String slaveStates = "";

        for (int i = 0; i < SlaveCNT; i++) {
            Serial.print(slaveSTATE[i]);
            slaveStates += String(slaveSTATE[i]);
        }
        Serial.println();

        str_msg.data = slaveStates.c_str();
        chatter.publish(&str_msg);

        for (int i = 0; i < SlaveCNT; i++) {
            if (millis() - lastUpdateTime[i] > timeoutInterval) {
                Serial.printf("Device %d is not alive.\n", i + 1);
            }
        }
        last_write_time = write_time;
    }
    delay(5);  // **Shortened delay to prevent watchdog timeout**
}

// **Dedicated MQTT & ROS Task on Core 0**
void mqttTask(void *pvParameters) {
    while (true) {
        esp_task_wdt_reset();  // **Reset watchdog inside task**
        nh.spinOnce();
        mqtt.loop();
        delay(10);
    }
}
