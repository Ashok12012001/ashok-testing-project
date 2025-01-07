#include "ros/ros.h"
#include <server_project/ImageRotation.h>
#include <sensor_msgs/Image.h>
#include <cv_bridge/cv_bridge.h>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/opencv.hpp>

bool rotateImage(server_project::ImageRotation::Request &req,
                 server_project::ImageRotation::Response &res)
{
    try
    {
        // Convert ROS image to OpenCV format
        cv_bridge::CvImagePtr cv_ptr = cv_bridge::toCvCopy(req.input_image, req.input_image.encoding);
        ROS_INFO("Received image of size: %dx%d", cv_ptr->image.cols, cv_ptr->image.rows);

        // Rotate the image
        cv::Mat rotated_image;
        cv::Point2f center(cv_ptr->image.cols / 2.0, cv_ptr->image.rows / 2.0);
        cv::Mat rotation_matrix = cv::getRotationMatrix2D(center, req.rotation_angle, 1.0);
        cv::warpAffine(cv_ptr->image, rotated_image, rotation_matrix, cv_ptr->image.size());

        // Convert back to ROS format
        cv_bridge::CvImage output_cv;
        output_cv.header = req.input_image.header;
        output_cv.encoding = req.input_image.encoding;
        output_cv.image = rotated_image;
        res.output_image = *output_cv.toImageMsg();

        ROS_INFO("Image rotated by %f degrees.", req.rotation_angle);
        return true;
    }
    catch (cv_bridge::Exception &e)
    {
        ROS_ERROR("cv_bridge exception: %s", e.what());
        return false;
    }
    catch (cv::Exception &e)
    {
        ROS_ERROR("OpenCV exception: %s", e.what());
        return false;
    }
}

int main(int argc, char **argv)
{
    ros::init(argc, argv, "image_rotation_server");
    ros::NodeHandle nh;

    ros::ServiceServer service = nh.advertiseService("rotate_image", rotateImage);
    ROS_INFO("Image rotation service ready.");
    ros::spin();

    return 0;
}
