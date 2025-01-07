#include "ros/ros.h"
#include "std_msgs/String.h"

void subcallback(const std_msgs::String::ConstPtr& msg) {
    std::string msg_str = msg->data;  
    ROS_INFO("%s", msg_str.c_str()); 
}

int main(int argc, char **argv) {
    ros::init(argc, argv, "asho_subscriber");  

    ros::NodeHandle node_handler;  
    ros::Subscriber asho_subscriber = node_handler.subscribe("hello_world_topic", 10, subcallback);

    ros::spin();  

    return 0;
}
