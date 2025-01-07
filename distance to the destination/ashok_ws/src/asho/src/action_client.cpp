#include <ros/ros.h>
#include "asho/ActionNameAction.h"
#include "actionlib/client/simple_action_client.h"

typedef actionlib::SimpleActionClient<asho::ActionNameAction> MyClient;

void activecallback()
{
    std::cout << "Action Activated" << std::endl;
}

void feedbackcallback(const asho::ActionNameFeedback::ConstPtr& feedback_var)
{
    std::cout << "Distance left: " << feedback_var->current_position << std::endl;
}

void resultcallback(const actionlib::SimpleClientGoalState& state_var,
                    const asho::ActionNameResult::ConstPtr& result_var)
{
    std::cout << result_var->message << std::endl;
}

int main(int argc, char** argv)
{
    ros::init(argc, argv, "action_client");
    MyClient client("action_topic_name", true);
    client.waitForServer();

    asho::ActionNameGoal goal;
    goal.target_position = 10.0;  // Set the target position to 10 (for example)

    client.sendGoal(goal, &resultcallback, &activecallback, &feedbackcallback);
    client.waitForResult();

    return 0;
}
