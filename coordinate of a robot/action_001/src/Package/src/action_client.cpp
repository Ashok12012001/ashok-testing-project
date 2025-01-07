#include "actionlib/client/simple_action_client.h"
#include "package/Navigate2DAction.h"
#include "ros/ros.h"
#include "geometry_msgs/Point.h"

typedef actionlib::SimpleActionClient<package::Navigate2DAction> NavClient;

// Global flag to indicate feedback processing
bool feedback_cb_ready_flag = false;

// Callback Functions
void activeCallback() {
  ROS_INFO("Goal Activated");
  feedback_cb_ready_flag = true;
}

void feedbackCallback(const package::Navigate2DFeedback::ConstPtr& feedback) {
  if (feedback_cb_ready_flag) {
    ROS_INFO("Distance to Goal: %.2f", feedback->distance_to_point);
  }
}

void resultCallback(const actionlib::SimpleClientGoalState& state,
                    const package::Navigate2DResult::ConstPtr& result) {
  ROS_INFO("Finished. Time Elapsed: %.2f seconds", result->elapsed_time);
  feedback_cb_ready_flag = false;
}

int main(int argc, char **argv) {
  ros::init(argc, argv, "navigate_2d_client_node");
  ros::NodeHandle node_handle;

  // Instantiate Action Client
  NavClient client("navigate_2d", true);
  client.waitForServer();

  // ROS Loop
  while (ros::ok()) {
    // Enter new goal coordinates
    package::Navigate2DGoal goal;
    std::cout << "\nEnter the X-Coordinate: ";
    std::cin >> goal.point.x;

    std::cout << "Enter the Y-Coordinate: ";
    std::cin >> goal.point.y;

    goal.point.z = 0.0;  // Assuming 2D navigation

    // Send the goal to the action server
    client.sendGoal(goal, &resultCallback, &activeCallback, &feedbackCallback);

    // Wait for the result before asking for the next goal
    client.waitForResult();

    // Print status and repeat
    ROS_INFO("Goal processed. Ready for the next goal.");
  }

  return 0;
}
