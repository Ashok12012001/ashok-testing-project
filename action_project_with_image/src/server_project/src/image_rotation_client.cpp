#include "ros/ros.h"
#include <server_project/ImageRotation.h>
#include <sensor_msgs/Image.h>
#include <cv_bridge/cv_bridge.h>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
int main(int argc, char **argv)
{
    ros::init(argc, argv, "image_rotation_client");
    ros::NodeHandle nh;

    ros::ServiceClient client = nh.serviceClient<server_project::ImageRotation>("rotate_image");
    server_project::ImageRotation srv;

    // Load an image (replace "path_to_image" with your image path)
    std::string image_path = "/home/ashokd/projects/action_project_with_image/src/server_project/resources/0.png";
;
    cv::Mat input_image = cv::imread(image_path, cv::IMREAD_COLOR);
    if (input_image.empty())
    {
        ROS_ERROR("Could not read input image from path: %s", image_path.c_str());    
        return 1;
    }

    // Convert OpenCV image to ROS format
    cv_bridge::CvImage cv_img;
    cv_img.image = input_image;
    cv_img.encoding = "bgr8";
    srv.request.input_image = *cv_img.toImageMsg();

    // Set rotation angle (e.g., 90 degrees)
    srv.request.rotation_angle = 90.0;
    

    if (client.call(srv))
    {
        ROS_INFO("Image rotated successfully.");
        // Convert and display the rotated image
        cv_bridge::CvImagePtr rotated_cv = cv_bridge::toCvCopy(srv.response.output_image, srv.response.output_image.encoding);
        cv::imshow("Rotated Image", rotated_cv->image);
        cv::waitKey(0);
    }
    else
    {
        ROS_ERROR("Failed to call service rotate_image.");
    }

    return 0;
}
