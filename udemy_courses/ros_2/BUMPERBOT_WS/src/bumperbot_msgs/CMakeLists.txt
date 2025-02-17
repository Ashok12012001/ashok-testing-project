cmake_minimum_required(VERSION 3.0.2)
project(bumperbot_msgs)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

find_package(catkin REQUIRED)
find_package(geometry_msgs REQUIRED)
find_package(rosidl_default_generators REQUIRED)

rosidl_generate_interfaces(${PROJECT_NAME}
  "action/Fibonacci.action"
  "srv/AddTwoInts.srv"
  "srv/GetTransform.srv"
  DEPENDENCIES geometry_msgs
)

catkin_package()
