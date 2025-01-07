#include "ros/ros.h"
#include "server_project/CameraControl.h"
#include "sensor_msgs/Image.h"

bool handleCameraRequest (server_project::CameraControl::Request &req,
                         server_project::CameraControl::Response &res) 
{
    ROS_INFO("Requested camera angle: %f degrees", req.angle);

    
    res.image.header.stamp = ros::Time::now();
    res.image.height = 640;
    res.image.width = 480;
    ROS_INFO("Returning simulated image.");

    return true;
}


int main(int argc, char **argv) 
{
    ros::init(argc, argv, "camera_service_server");
    ros::NodeHandle nh;

    ros::ServiceServer service = nh.advertiseService("server_project", handleCameraRequest);
    ROS_INFO("Camera service server is ready.");

    ros::spin();
    return 0;
}
