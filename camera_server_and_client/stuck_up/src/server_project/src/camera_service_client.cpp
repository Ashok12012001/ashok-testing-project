#include "ros/ros.h"
#include "server_project/CameraControl.h"

//#include "server_project/CameraControl.h"

int main (int argc, char **argv)
{
    ros::init(argc, argv, "camera_service_client");
    ros::NodeHandle nh;
    int rotation_degree;
if (ros::param::get("rotation_degree", rotation_degree)) 
{
        ROS_INFO("Rotation_degree: %d", rotation_degree);
    } 
else
    {
        ROS_WARN("Rotation degree parameter not set. Using default.");
}


    ros::ServiceClient client = nh.serviceClient<server_project::CameraControl>("server_project");

    server_project::CameraControl srv;
    srv.request.angle = 90.0;  

    if (client.call(srv)) {
        ROS_INFO("Received image with size: %dx%d", srv.response.image.width, srv.response.image.height);
    } else {
        ROS_ERROR("Failed to call service server_project");
    }

    return 0;
}
