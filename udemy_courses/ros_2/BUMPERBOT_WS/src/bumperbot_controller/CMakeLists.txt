cmake_minimum_required(VERSION 3.0.2)
project(bumperbot_controller)

find_package(catkin REQUIRED)
find_package(catkin_python REQUIRED)
find_package(rclcpp REQUIRED)
find_package(rclpy REQUIRED)
find_package(geometry_msgs REQUIRED)
find_package(std_msgs REQUIRED)
find_package(sensor_msgs REQUIRED)
find_package(nav_msgs REQUIRED)
find_package(tf2_ros REQUIRED)
find_package(tf2 REQUIRED)
find_package(Eigen3 REQUIRED)

include_directories(include)
include_directories(${EIGEN3_INCLUDE_DIR})

add_executable(simple_controller src/simple_controller.cpp)
catkin_target_dependencies(simple_controller rclcpp geometry_msgs std_msgs sensor_msgs nav_msgs tf2_ros tf2 ${Eigen_LIBRARIES})

add_executable(noisy_controller src/noisy_controller.cpp)
catkin_target_dependencies(noisy_controller rclcpp geometry_msgs sensor_msgs nav_msgs tf2_ros tf2)

add_executable(twist_relay src/twist_relay.cpp)
catkin_target_dependencies(twist_relay rclcpp geometry_msgs)

catkin_python_install_package(${PROJECT_NAME})

install(
  DIRECTORY include
  DESTINATION include
)

install(TARGETS
  simple_controller
  noisy_controller
  twist_relay
  DESTINATION lib/${PROJECT_NAME}
)

install(
  DIRECTORY launch config
  DESTINATION share/${PROJECT_NAME}
)

install(PROGRAMS
  ${PROJECT_NAME}/simple_controller.py
  ${PROJECT_NAME}/noisy_controller.py
  ${PROJECT_NAME}/twist_relay.py
  DESTINATION lib/${PROJECT_NAME}
)

catkin_package()
