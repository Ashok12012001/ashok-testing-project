#include "ros/ros.h"
#include "geometry_msgs/Point.h"
#include "actionlib/server/simple_action_server.h"
#include "package/Navigate2DAction.h"
#include <cmath>

class Navigate2DServer
{
public:
    Navigate2DServer(const std::string& name)
        : server_(node_handle_, name, false), DIST_THRESHOLD(0.1) // Initialize DIST_THRESHOLD
    {
        // Register goal and preempt callbacks
        server_.registerGoalCallback(boost::bind(&Navigate2DServer::goalCallback, this));
        server_.registerPreemptCallback(boost::bind(&Navigate2DServer::preemptCallback, this));
        server_.start();

        // Subscribe to robot's position topic
        position_subscriber_ = node_handle_.subscribe("robot_position", 10, &Navigate2DServer::positionCallback, this);

        // Initialize robot position
        robot_current_position_.x = 0; 
        robot_current_position_.y = 0;
    }

private:
    ros::NodeHandle node_handle_;
    actionlib::SimpleActionServer<package::Navigate2DAction> server_;
    ros::Subscriber position_subscriber_;
    geometry_msgs::Point robot_current_position_;
    const float DIST_THRESHOLD; // Declare as a class constant

    void goalCallback()
    {
        // Accept the new goal and start the action
        package::Navigate2DGoalConstPtr goal = server_.acceptNewGoal();
        package::Navigate2DFeedback feedback_msg;
        package::Navigate2DResult result_msg;

        double goal_received_time = ros::Time::now().toSec();
        ROS_INFO("Goal Received");

        float dist = distanceToGoal(goal->point);

        ros::Rate feedback_rate(2);  // Set feedback rate to 2Hz
        while (dist > DIST_THRESHOLD)
        {
            dist = distanceToGoal(goal->point);
            feedback_msg.distance_to_point = dist;
            server_.publishFeedback(feedback_msg);
            feedback_rate.sleep();
        }

        double goal_reached_time = ros::Time::now().toSec();
        ROS_INFO("Goal Reached");

        double elapsed_time = goal_reached_time - goal_received_time;
        result_msg.elapsed_time = elapsed_time;

        // Mark the goal as succeeded
        server_.setSucceeded(result_msg);

        // Re-enable the server to accept the next goal
        ROS_INFO("Server is ready to accept the next goal.");
    }

    void preemptCallback()
    {
        ROS_INFO("Goal Preempted");
        server_.setPreempted();
    }

    void positionCallback(const geometry_msgs::Point::ConstPtr& msg)
    {
        robot_current_position_ = *msg;
    }

    float distanceToGoal(const geometry_msgs::Point& goal_point)
    {
        return std::sqrt(std::pow(robot_current_position_.x - goal_point.x, 2) +
                         std::pow(robot_current_position_.y - goal_point.y, 2));
    }
};

int main(int argc, char** argv)
{
    ros::init(argc, argv, "navigate_2d_server_node");
    Navigate2DServer server("navigate_2d");  // Create the server
    ros::spin();  // Keep the server running
    return 0;
}
