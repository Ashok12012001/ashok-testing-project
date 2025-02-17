cmake_minimum_required(VERSION 3.0.2)
project(bumperbot_localization)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()


find_package(catkin REQUIRED)
find_package(catkin_python REQUIRED)
find_package(rclcpp REQUIRED)
find_package(rclpy REQUIRED)
find_package(nav_msgs REQUIRED)
find_package(sensor_msgs REQUIRED)
find_package(geometry_msgs REQUIRED)
find_package(tf2 REQUIRED)

include_directories(include)

add_executable(kalman_filter src/kalman_filter.cpp)
catkin_target_dependencies(kalman_filter rclcpp nav_msgs sensor_msgs)

add_executable(imu_republisher src/imu_republisher.cpp)
catkin_target_dependencies(imu_republisher rclcpp sensor_msgs)

add_executable(odometry_motion_model src/odometry_motion_model.cpp)
catkin_target_dependencies(odometry_motion_model rclcpp tf2 nav_msgs geometry_msgs)

catkin_python_install_package(${PROJECT_NAME})

install(
  DIRECTORY include
  DESTINATION include
)

install(TARGETS
  odometry_motion_model
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  RUNTIME DESTINATION bin
)

install(TARGETS
  kalman_filter
  imu_republisher
  odometry_motion_model
  DESTINATION lib/${PROJECT_NAME}
)

install(
  DIRECTORY launch config rviz
  DESTINATION share/${PROJECT_NAME}
)

install(PROGRAMS
  ${PROJECT_NAME}/kalman_filter.py
  ${PROJECT_NAME}/imu_republisher.py
  ${PROJECT_NAME}/odometry_motion_model.py
  DESTINATION lib/${PROJECT_NAME}
)

catkin_package()
