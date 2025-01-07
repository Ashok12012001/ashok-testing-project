#include <ros/ros.h>
#include <sensor_msgs/LaserScan.h>

int main(int argc, char** argv) {
    ros::init(argc, argv, "sensor_publisher_node");
    ros::NodeHandle nh;

    // Create a publisher for the LaserScan topic
    ros::Publisher scan_pub = nh.advertise<sensor_msgs::LaserScan>("scan", 10);

    // Create a LaserScan message
    sensor_msgs::LaserScan scan;
    scan.header.frame_id = "base_scan";  // Frame ID (can be adjusted)
    scan.angle_min = -3.14;  // -PI
    scan.angle_max = 3.14;   // PI
    scan.angle_increment = 0.1;  // Angular increment between measurements
    scan.range_min = 0.1;  // Min range (meters)
    scan.range_max = 10.0; // Max range (meters)

    // Use ros::Rate to set the publishing rate (e.g., 10 Hz)
    ros::Rate loop_rate(10);  // 10 Hz

    // Start publishing in a loop
    while (ros::ok()) {
        // Update the header timestamp
        scan.header.stamp = ros::Time::now();

        // Fill in mock data for the laser scan (you can modify this for your application)
        scan.ranges.clear();  // Clear previous data
        for (int i = 0; i < 10; ++i) {
            scan.ranges.push_back(5.0);  // Push mock range data
        }

        // Publish the sensor data
        scan_pub.publish(scan);

        // Sleep to maintain the loop rate
        loop_rate.sleep();
    }

    return 0;
}




// #include<ros/ros.h>
// #include<geometry_msgs/Twist.h>
// #include<sensor_msgs/LaserScan.h>

// void velocityCallback(const geometry_msgs::Twist& msg)
// {
//     ROS_INFO("linear velocity = %f, angular velocity = %f", msg.linear.x, msg.angular.z);
// }
// ros::Publisher scan_pub = nh.advertise<sensor_msgs::LaserScan>("scan", 10);
// sensor_msgs::LaserScan scan_msg;
// scan.header.stamp = ros::Time::now();
// scan.header.frame_id = "base_scan";

// scan.angle_min = -3.14;
// scan.angle_max = 3.14;
// scan.range_min = 0.1;
// scan.range_max = 10.0;
// scan.range.push_back(5.0);
// int main(int argc, char **argv)
// {
//     ros::init(argc, argv, "robot_node");
//     ros::NodeHandle nh;
//     ros::Subscriber sub = nh.subscribe("cmd_vel", 10, velocityCallback);
//    ////for creating a launch and param file 
//     // double wheel_radius, wheel_base, max_speed;
//     // nh.getParam("robot_params/wheel_radius", wheel_radius);
//     // nh.getParam("robot_params/wheel_base", wheel_base);
//     // nh.getParam("robot_params/max_speed", max_speed);///////
    
//     // ROS_INFO("Robot parameters: Radius = %f, Base = %f, Max Speed = %f", wheel_radius, wheel_base, max_speed);
// /////
//     ros::spin();
//     return 0;
// }