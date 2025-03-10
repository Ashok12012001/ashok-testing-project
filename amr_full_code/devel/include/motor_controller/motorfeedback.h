// Generated by gencpp from file motor_controller/motorfeedback.msg
// DO NOT EDIT!


#ifndef MOTOR_CONTROLLER_MESSAGE_MOTORFEEDBACK_H
#define MOTOR_CONTROLLER_MESSAGE_MOTORFEEDBACK_H


#include <string>
#include <vector>
#include <memory>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace motor_controller
{
template <class ContainerAllocator>
struct motorfeedback_
{
  typedef motorfeedback_<ContainerAllocator> Type;

  motorfeedback_()
    : rotates(0.0)
    , speed(0.0)
    , left_wheel_tickes(0)
    , right_wheel_tickes(0)  {
    }
  motorfeedback_(const ContainerAllocator& _alloc)
    : rotates(0.0)
    , speed(0.0)
    , left_wheel_tickes(0)
    , right_wheel_tickes(0)  {
  (void)_alloc;
    }



   typedef float _rotates_type;
  _rotates_type rotates;

   typedef float _speed_type;
  _speed_type speed;

   typedef int16_t _left_wheel_tickes_type;
  _left_wheel_tickes_type left_wheel_tickes;

   typedef int16_t _right_wheel_tickes_type;
  _right_wheel_tickes_type right_wheel_tickes;





  typedef boost::shared_ptr< ::motor_controller::motorfeedback_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::motor_controller::motorfeedback_<ContainerAllocator> const> ConstPtr;

}; // struct motorfeedback_

typedef ::motor_controller::motorfeedback_<std::allocator<void> > motorfeedback;

typedef boost::shared_ptr< ::motor_controller::motorfeedback > motorfeedbackPtr;
typedef boost::shared_ptr< ::motor_controller::motorfeedback const> motorfeedbackConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::motor_controller::motorfeedback_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::motor_controller::motorfeedback_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::motor_controller::motorfeedback_<ContainerAllocator1> & lhs, const ::motor_controller::motorfeedback_<ContainerAllocator2> & rhs)
{
  return lhs.rotates == rhs.rotates &&
    lhs.speed == rhs.speed &&
    lhs.left_wheel_tickes == rhs.left_wheel_tickes &&
    lhs.right_wheel_tickes == rhs.right_wheel_tickes;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::motor_controller::motorfeedback_<ContainerAllocator1> & lhs, const ::motor_controller::motorfeedback_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace motor_controller

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::motor_controller::motorfeedback_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::motor_controller::motorfeedback_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::motor_controller::motorfeedback_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::motor_controller::motorfeedback_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::motor_controller::motorfeedback_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::motor_controller::motorfeedback_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::motor_controller::motorfeedback_<ContainerAllocator> >
{
  static const char* value()
  {
    return "8dc03d848f56907041b4a626e48c93fa";
  }

  static const char* value(const ::motor_controller::motorfeedback_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x8dc03d848f569070ULL;
  static const uint64_t static_value2 = 0x41b4a626e48c93faULL;
};

template<class ContainerAllocator>
struct DataType< ::motor_controller::motorfeedback_<ContainerAllocator> >
{
  static const char* value()
  {
    return "motor_controller/motorfeedback";
  }

  static const char* value(const ::motor_controller::motorfeedback_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::motor_controller::motorfeedback_<ContainerAllocator> >
{
  static const char* value()
  {
    return "float32 rotates\n"
"float32 speed\n"
"int16 left_wheel_tickes\n"
"int16 right_wheel_tickes\n"
"\n"
;
  }

  static const char* value(const ::motor_controller::motorfeedback_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::motor_controller::motorfeedback_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.rotates);
      stream.next(m.speed);
      stream.next(m.left_wheel_tickes);
      stream.next(m.right_wheel_tickes);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct motorfeedback_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::motor_controller::motorfeedback_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::motor_controller::motorfeedback_<ContainerAllocator>& v)
  {
    s << indent << "rotates: ";
    Printer<float>::stream(s, indent + "  ", v.rotates);
    s << indent << "speed: ";
    Printer<float>::stream(s, indent + "  ", v.speed);
    s << indent << "left_wheel_tickes: ";
    Printer<int16_t>::stream(s, indent + "  ", v.left_wheel_tickes);
    s << indent << "right_wheel_tickes: ";
    Printer<int16_t>::stream(s, indent + "  ", v.right_wheel_tickes);
  }
};

} // namespace message_operations
} // namespace ros

#endif // MOTOR_CONTROLLER_MESSAGE_MOTORFEEDBACK_H
