#include <Arduino.h>
#include <WiFi.h>
#include <PubSubClient.h>
#include <ESPmDNS.h>
#include <EEPROM.h>
#include <esp_task_wdt.h>
// 15 seconds WDT
#define WDT_TIMEOUT 15

const char *slave_ID = "0";
const char *ssid = "Project_AQM";
const char *password = "AQM##2220";
const char *mqtt_server = "amr";
const int mqtt_port = 1883;
#define LED 2
byte pin_state;
WiFiClient espClient;
// MQTTClient client;
PubSubClient Mqttclient(espClient);

byte addr[5];             // address of CLiID, DEvID,  SSID, PSK
byte MAX_S = 20;          // maximum length of credentials
String DEvID = "0";       // default device ID
String uplinkF = "1000";  // default device uplink time
String waitTIME = "5000"; // default device wait time

void write_String(char add, String data)
{
  // Serial.println("---> write_String");
  int i;
  for (i = 0; i < MAX_S; i++)
  {
    EEPROM.write(add + i, 0);
  }

  int _size = data.length();
  for (i = 0; i < _size; i++)
  {
    EEPROM.write(add + i, data[i]);
  }
  EEPROM.write(add + _size, '\0'); // Add termination null character for String Data
  EEPROM.commit();
}

String read_String(char add)
{
  // Serial.println("---> read_String");

  char data[100]; // Max 100 Bytes
  int len = 0;
  unsigned char k;
  k = EEPROM.read(add);
  while (k != '\0' && len < 500) // Read until null character
  {
    k = EEPROM.read(add + len);
    data[len] = k;
    len++;
  }
  data[len] = '\0';
  return String(data);
}
bool DEVID_CHECK()
{
  if (read_String(addr[3]).toInt() == 123)
  {
    return true;
  }
  else
    return false;
}
void retreive_EEPROM()
{
  // Serial.println("---> retreive_EEPROM");
  // Serial.println();
  // Serial.println("--------------------------");
  // Serial.println("Retreiving data from EEPROM");

  DEvID = read_String(addr[0]);
  Serial.print("DEvID:");
  Serial.println(DEvID);

  uplinkF = String(read_String(addr[1]).toInt() * 1000);

  Serial.print("uplinkF: ");
  Serial.println(uplinkF);

  waitTIME = String(read_String(addr[2]).toInt() * 1000);

  Serial.print("waitTIME: ");
  Serial.println(waitTIME);
  // Serial.println("--------------------------");
}

void connect()
{

  Serial.print("checking wifi...");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(1000);
  }

  Serial.print("\nconnecting...");
  while (!Mqttclient.connect((slave_ID + random(300) + random(300)), "public", "public"))
  {
    Serial.print(".");
    delay(1000);
  }

  Serial.println("\nconnected TO MQTT");

  Mqttclient.subscribe(slave_ID);
  // client.unsubscribe("/hello");
}

struct GPIO_IP
{
  const uint8_t PIN;
  uint32_t numberKeyPresses;
  bool pressed;
  int slave_state;
};

GPIO_IP input_state = {15, 0, false, 0};

// variables to keep track of the timing of recent interrupts
volatile bool pinHighFlag = false;
unsigned long lastPrintTime = 0;
unsigned long debounceStartTime = 0; // Debounce time in milliseconds (to ignore bouncing)

void indication(int num, unsigned long on, unsigned long off)
{
  for (int i = 0; i < num; i++)
  {
    digitalWrite(2, HIGH);
    delay(on);
    digitalWrite(2, LOW);
    delay(off);
  }
}

void MQTT_publish(String Topic, String Message, int d)
{
  // Serial.println("---> MQTT_publish");
  // Serial.print(Topic);
  // Serial.print(":");
  // Serial.println(Message);
  Mqttclient.publish(Topic.c_str(), Message.c_str());
  indication(d, 200, 200);
}

void WiFi_connect()
{
  // Serial.println("---> WiFi_connect");
  uint8_t rtr = 0;
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED && rtr < 20)
  {
    for (int dutyCycle = 255; dutyCycle > 0; dutyCycle--)
    {
      analogWrite(2, dutyCycle);
      delay(1);
    }

    for (int dutyCycle = 0; dutyCycle < 255; dutyCycle++)
    {
      analogWrite(2, dutyCycle);
      delay(1);
    }
    // Serial.print(".");
    rtr++;
  }
  if (rtr == 20)
  {
    // Serial.println();
    // Serial.print("Unable to Connect to ");
    // Serial.println(SSID);
    // Serial.println("I'm going to Restart");
    delay(2000);
    ESP.restart();
  }

  // Serial.println();
  // Serial.print("Connected to WiFi :");
  // Serial.println(WiFi.SSID());
  Serial.println(WiFi.localIP().toString());
}

void MQTT_connect()
{
  // Serial.println("---> MQTT_connect");
  // Serial.println("Connecting to MQTT...");
  while (!Mqttclient.connected())
  {
    if (WiFi.status() != WL_CONNECTED)
    {
      WiFi_connect();
    }
    else if (Mqttclient.connect(String(DEvID).c_str() + random(300) + random(300))) // FLDEC Instance
    {

      Serial.println("\nconnected TO MQTT");

      Mqttclient.subscribe(String(DEvID).c_str());
      ;
    }
    else
    {
      indication(4, 200, 200);
      delay(2000);
    }
  }
}

void IRAM_ATTR isr()
{
  pinHighFlag = true;
  return;
}

void MQTTcallback(char *topic, byte *payload, unsigned int length)
{
  // Serial.println("---> MQTTcallback");
  // Serial.println();
  // Serial.println("------------------------");
  // Serial.print("Message received in topic: ");
  // Serial.println(topic);
  // Serial.print("Message:");

  String message;
  for (unsigned int i = 0; i < length; i++)
  {
    message = message + (char)payload[i];
  }

  Serial.println("MQTT SUB data: " + String(topic) + " - " + message);

  if (String(topic) == DEvID)
  {

    int count = 0;
    for (int i = 0; i < message.length(); i++)
    {
      if (message.charAt(i) == ',')
      {
        count++;
      }
    }
    Serial.println(count);

    if (count == 2)
    { // Check if there are exactly 2 commas

      int commaIndex1 = (message).indexOf(',');                  // First comma
      int commaIndex2 = (message).indexOf(',', commaIndex1 + 1); // Second comma
      int commaIndex3 = (message).indexOf(',', commaIndex2 + 1); // Third comma

      if ((commaIndex1) && (commaIndex2))
      {
        // Extract the values before the first comma, between first and second comma, and after the third comma
        DEvID = message.substring(0, commaIndex1).toInt();                 // Get the part before the first comma
        uplinkF = message.substring(commaIndex1 + 1, commaIndex2).toInt(); // Get the part between the first and second commas
        waitTIME = message.substring(commaIndex2 + 1).toInt();             // Get the part between the second and third commas

        // Print out the extracted values (for debugging)
        Serial.println("DEvID: " + String(DEvID));
        Serial.println("uplink Freq: " + String(uplinkF));
        Serial.println("waitTIME: " + String(waitTIME));

        write_String(addr[0], String(DEvID));
        write_String(addr[1], String(uplinkF));
        write_String(addr[2], String(waitTIME));
        write_String(addr[3], "123");
        delay(100);
        ESP.restart();
      }
      else
      {
        // If not exactly 3 commas found, do nothing
        return;
      }
    }
  }
}

void setup()
{

  esp_task_wdt_init(WDT_TIMEOUT, true); // enable panic so ESP32 restarts
  esp_task_wdt_add(NULL);               // add current thread to WDT watch

  EEPROM.begin(112);
  delay(4000);
  Serial.begin(115200);

  for (byte i = 0; i < sizeof(addr); i++)
  {
    addr[i] = (i * MAX_S) + 1;
  }

  if (DEVID_CHECK())
  {
    retreive_EEPROM();
  }
  esp_task_wdt_reset();
  pinMode(input_state.PIN, INPUT_PULLDOWN);

  attachInterrupt(input_state.PIN, isr, RISING);
  WiFi_connect();
  Mqttclient.setCallback(MQTTcallback);

  IPAddress AMR_mqtt;

  // Query mDNS for the service of "AMR_mqtt" (this resolves IP address)
  if (MDNS.begin(slave_ID))
  {                                         // Try to resolve the service "esp32.local"
    AMR_mqtt = MDNS.queryHost(mqtt_server); // This will query the IP for "esp32.local"

    if (AMR_mqtt)
    {
      Serial.print("Found esp32.local with IP: ");
      Serial.println(AMR_mqtt); // Prints the IP address of the first ESP32
    }
    else
    {
      Serial.println("Could not find esp32.local");
      ESP.restart();
    }
  }

  Mqttclient.setServer(AMR_mqtt, mqtt_port);
  MQTT_connect();
  pinMode(2, OUTPUT);
  pin_state = digitalRead(input_state.PIN);
}

void loop()
{
  esp_task_wdt_reset();
  Mqttclient.loop();

  if (!Mqttclient.connected())
  {
    MQTT_connect();
  }
  if (pinHighFlag)
  {
    debounceStartTime = millis(); // Start the debounce timer
    pinHighFlag = false;          // Reset the flag immediately after detecting the interrupt
  }
  // Check if  seconds have passed since the pin went HIGH
  if (debounceStartTime > 0 && millis() - debounceStartTime >= waitTIME.toInt())
  {
    if (digitalRead(input_state.PIN) == HIGH)
    {
      Serial.println("Pin remained HIGH for" + String(waitTIME.toInt() / 1000) + "seconds.");
      pin_state = 1;
      lastPrintTime = millis();
    }
    else
    {
      Serial.println("Pin went LOW before " + String(waitTIME.toInt() / 1000) + "seconds.");
      pin_state = 0;
    }
    debounceStartTime = 0; // Reset debounce timer
  }
  if (millis() - lastPrintTime >= uplinkF.toInt())
  {
    lastPrintTime = millis();
    int state = digitalRead(input_state.PIN);
    Serial.print("GPIO Pin State: ");
    Serial.println(state); // Print state (HIGH or LOW)
    if (pin_state == 1 && digitalRead(input_state.PIN) == 1)
    {
      MQTT_publish("SLstate", String(DEvID) + "," + 1, 2);
    }
    else if (digitalRead(input_state.PIN) == 0)
    {
      pinHighFlag = false; // Reset the flag
      pin_state = 0;
      MQTT_publish("SLstate", String(DEvID) + "," + 0, 2);
    }
  }
}
