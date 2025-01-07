#include "ros/ros.h"
#include "package/ImageProcessing.h"
#include "package/MyMessage.h"
#include "sensor_msgs/Image.h"


bool cameraClient(float angle)
{
    ros::NodeHandle n;
    ros::ServiceClient client = n.serviceClient<package::ImageProcessing>("camera_control");
    package::ImageProcessing srv;
    // package::MyMessage msg;
    // msg.name="camera";
    // msg.id = 1;
    // msg.values = {1.1,2.2,3.3}
    
    srv.request.angle = angle;  

    if (client.call(srv))
    {
        ROS_INFO("Received image data with resolution: %d x %d", srv.response.image.height, srv.response.image.width);
        return true;
    }
    else
    {
        ROS_ERROR("Service call failed");
        return false;
    }
}

int main(int argc, char **argv)
{
    ros::init(argc, argv, "camera_service_client");
    float angle;
    
    std::string role;
    ROS_INFO("Enter 'server' to run the service server or 'client' to run the client: ");
    std::cin >> role;
    
    if (role == "server")
    {
        
        // camera_server();
    }
    else if (role == "client")
    {
        std::cout << "Enter the desired camera angle: ";
        std::cin >> angle;
        cameraClient(angle);
    }
    else
    {
        ROS_ERROR("Invalid role specified.");
    }
    return 0;
}
