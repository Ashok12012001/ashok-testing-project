# Install script for directory: /home/ashokd/ashokd/projects/udemy_courses/Project_Walkthrough_Actions/src/udemy_cpp_pkg

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/ashokd/ashokd/projects/udemy_courses/Project_Walkthrough_Actions/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/udemy_cpp_pkg/srv" TYPE FILE FILES
    "/home/ashokd/ashokd/projects/udemy_courses/Project_Walkthrough_Actions/src/udemy_cpp_pkg/srv/OddEvenCheck.srv"
    "/home/ashokd/ashokd/projects/udemy_courses/Project_Walkthrough_Actions/src/udemy_cpp_pkg/srv/TurnCamera.srv"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/udemy_cpp_pkg/action" TYPE FILE FILES "/home/ashokd/ashokd/projects/udemy_courses/Project_Walkthrough_Actions/src/udemy_cpp_pkg/action/Navigate2D.action")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/udemy_cpp_pkg/msg" TYPE FILE FILES
    "/home/ashokd/ashokd/projects/udemy_courses/Project_Walkthrough_Actions/devel/share/udemy_cpp_pkg/msg/Navigate2DAction.msg"
    "/home/ashokd/ashokd/projects/udemy_courses/Project_Walkthrough_Actions/devel/share/udemy_cpp_pkg/msg/Navigate2DActionGoal.msg"
    "/home/ashokd/ashokd/projects/udemy_courses/Project_Walkthrough_Actions/devel/share/udemy_cpp_pkg/msg/Navigate2DActionResult.msg"
    "/home/ashokd/ashokd/projects/udemy_courses/Project_Walkthrough_Actions/devel/share/udemy_cpp_pkg/msg/Navigate2DActionFeedback.msg"
    "/home/ashokd/ashokd/projects/udemy_courses/Project_Walkthrough_Actions/devel/share/udemy_cpp_pkg/msg/Navigate2DGoal.msg"
    "/home/ashokd/ashokd/projects/udemy_courses/Project_Walkthrough_Actions/devel/share/udemy_cpp_pkg/msg/Navigate2DResult.msg"
    "/home/ashokd/ashokd/projects/udemy_courses/Project_Walkthrough_Actions/devel/share/udemy_cpp_pkg/msg/Navigate2DFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/udemy_cpp_pkg/cmake" TYPE FILE FILES "/home/ashokd/ashokd/projects/udemy_courses/Project_Walkthrough_Actions/build/udemy_cpp_pkg/catkin_generated/installspace/udemy_cpp_pkg-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/ashokd/ashokd/projects/udemy_courses/Project_Walkthrough_Actions/devel/include/udemy_cpp_pkg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/ashokd/ashokd/projects/udemy_courses/Project_Walkthrough_Actions/devel/share/roseus/ros/udemy_cpp_pkg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/ashokd/ashokd/projects/udemy_courses/Project_Walkthrough_Actions/devel/share/common-lisp/ros/udemy_cpp_pkg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/ashokd/ashokd/projects/udemy_courses/Project_Walkthrough_Actions/devel/share/gennodejs/ros/udemy_cpp_pkg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/ashokd/ashokd/projects/udemy_courses/Project_Walkthrough_Actions/devel/lib/python3/dist-packages/udemy_cpp_pkg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/ashokd/ashokd/projects/udemy_courses/Project_Walkthrough_Actions/devel/lib/python3/dist-packages/udemy_cpp_pkg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/ashokd/ashokd/projects/udemy_courses/Project_Walkthrough_Actions/build/udemy_cpp_pkg/catkin_generated/installspace/udemy_cpp_pkg.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/udemy_cpp_pkg/cmake" TYPE FILE FILES "/home/ashokd/ashokd/projects/udemy_courses/Project_Walkthrough_Actions/build/udemy_cpp_pkg/catkin_generated/installspace/udemy_cpp_pkg-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/udemy_cpp_pkg/cmake" TYPE FILE FILES
    "/home/ashokd/ashokd/projects/udemy_courses/Project_Walkthrough_Actions/build/udemy_cpp_pkg/catkin_generated/installspace/udemy_cpp_pkgConfig.cmake"
    "/home/ashokd/ashokd/projects/udemy_courses/Project_Walkthrough_Actions/build/udemy_cpp_pkg/catkin_generated/installspace/udemy_cpp_pkgConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/udemy_cpp_pkg" TYPE FILE FILES "/home/ashokd/ashokd/projects/udemy_courses/Project_Walkthrough_Actions/src/udemy_cpp_pkg/package.xml")
endif()

