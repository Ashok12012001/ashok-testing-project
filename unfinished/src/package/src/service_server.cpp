#include "ros/ros.h"
#include "package/ImageProcessing.h"
#include "sensor_msgs/Image.h"
#include "package/MyMessage.h"

bool handleCameraRequest(package::ImageProcessing::Request &req, package::ImageProcessing::Response &res)
{
    ROS_INFO("Received request to change camera angle to %f degrees.", req.angle);
    
    
    sensor_msgs::Image img;
    img.header.stamp = ros::Time::now();
    img.height = 480;
    img.width = 640;
    
    
    img.encoding = "rgb8";  
    img.step = img.width * 3; 

    ROS_INFO("Returning simulated image data.");
    
    res.image = img;  
    return true;
}

int main(int argc, char **argv)
{
    ros::init(argc, argv, "camera_service_server");  
    ros::NodeHandle nh;
    ros::ServiceServer service = nh.advertiseService("camera_control", &handleCameraRequest);

    ROS_INFO("Camera service server is ready.");
    
    ros::spin();  
    return 0;
}
