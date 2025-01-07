#include <asho/ActionNameAction.h>
#include <ros/ros.h>
#include "actionlib/server/simple_action_server.h"
#include <cmath>

typedef actionlib::SimpleActionServer<asho::ActionNameAction> MyServer;

void mycallback(const asho::ActionNameGoalConstPtr& goal_point, MyServer* my_server)
{
    ros::Rate feedback_rate(2);
    asho::ActionNameFeedback feedback_msg;
    asho::ActionNameResult res_msg;

    float target_position = goal_point->target_position;
    float current_position = 0.0; // Assuming starting position is 0, can be updated dynamically.

    while (current_position < target_position)
    {
        float distance_left = target_position - current_position;
        feedback_msg.current_position = distance_left;

        my_server->publishFeedback(feedback_msg);
        ROS_INFO("Distance left: %.2f", distance_left);
        
        current_position += 1.0;  // Simulate movement (e.g., incrementing by 1 each loop)

        feedback_rate.sleep();
    }

    // Once the goal is reached, set the result
    res_msg.success = true;
    res_msg.message = "Target reached successfully!";
    my_server->setSucceeded(res_msg);
}

int main(int argc, char** argv)
{
    ros::init(argc, argv, "action_server");
    ros::NodeHandle node_handle_var;
    
    MyServer server(node_handle_var, "action_topic_name", 
                    boost::bind(&mycallback, _1, &server), false);
    server.start();

    ros::spin();
    return 0;
}
