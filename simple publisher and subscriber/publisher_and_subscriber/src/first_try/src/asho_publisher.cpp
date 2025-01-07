#include "ros/ros.h"
#include "std_msgs/String.h"  

int main(int argc, char **argv)
{
    ros::init(argc, argv, "asho_publisher");
    ros::NodeHandle node_handler;

    ros::Publisher hello_world_pub = node_handler.advertise<std_msgs::String>("hello_world_topic", 10);
    ros::Rate asho_publisher_rate(5);

    ROS_INFO("PUBLISHER HAS STARTED");
    int counter = 0;

    while (ros::ok())
    {
        std_msgs::String msg;
        msg.data = "hey whazi" + std::to_string(counter);

        hello_world_pub.publish(msg);

        counter++;
        asho_publisher_rate.sleep();
    //ros::spin();

    }

    return 0;
}
