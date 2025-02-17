cmake_minimum_required(VERSION 3.0.2)
project(bumperbot_description)

find_package(catkin REQUIRED COMPONENTS
  urdf
)

catkin_package()

install(
  DIRECTORY launch meshes models photos urdf rviz worlds
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)

if(CATKIN_ENABLE_TESTING)
  find_package(catkin_lint_auto REQUIRED)
  catkin_lint_auto_find_test_dependencies()
endif()

