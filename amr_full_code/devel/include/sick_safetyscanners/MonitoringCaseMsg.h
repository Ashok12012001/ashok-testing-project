// Generated by gencpp from file sick_safetyscanners/MonitoringCaseMsg.msg
// DO NOT EDIT!


#ifndef SICK_SAFETYSCANNERS_MESSAGE_MONITORINGCASEMSG_H
#define SICK_SAFETYSCANNERS_MESSAGE_MONITORINGCASEMSG_H


#include <string>
#include <vector>
#include <memory>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace sick_safetyscanners
{
template <class ContainerAllocator>
struct MonitoringCaseMsg_
{
  typedef MonitoringCaseMsg_<ContainerAllocator> Type;

  MonitoringCaseMsg_()
    : monitoring_case_number(0)
    , fields()
    , fields_valid()  {
    }
  MonitoringCaseMsg_(const ContainerAllocator& _alloc)
    : monitoring_case_number(0)
    , fields(_alloc)
    , fields_valid(_alloc)  {
  (void)_alloc;
    }



   typedef int32_t _monitoring_case_number_type;
  _monitoring_case_number_type monitoring_case_number;

   typedef std::vector<int32_t, typename std::allocator_traits<ContainerAllocator>::template rebind_alloc<int32_t>> _fields_type;
  _fields_type fields;

   typedef std::vector<uint8_t, typename std::allocator_traits<ContainerAllocator>::template rebind_alloc<uint8_t>> _fields_valid_type;
  _fields_valid_type fields_valid;





  typedef boost::shared_ptr< ::sick_safetyscanners::MonitoringCaseMsg_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::sick_safetyscanners::MonitoringCaseMsg_<ContainerAllocator> const> ConstPtr;

}; // struct MonitoringCaseMsg_

typedef ::sick_safetyscanners::MonitoringCaseMsg_<std::allocator<void> > MonitoringCaseMsg;

typedef boost::shared_ptr< ::sick_safetyscanners::MonitoringCaseMsg > MonitoringCaseMsgPtr;
typedef boost::shared_ptr< ::sick_safetyscanners::MonitoringCaseMsg const> MonitoringCaseMsgConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::sick_safetyscanners::MonitoringCaseMsg_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::sick_safetyscanners::MonitoringCaseMsg_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::sick_safetyscanners::MonitoringCaseMsg_<ContainerAllocator1> & lhs, const ::sick_safetyscanners::MonitoringCaseMsg_<ContainerAllocator2> & rhs)
{
  return lhs.monitoring_case_number == rhs.monitoring_case_number &&
    lhs.fields == rhs.fields &&
    lhs.fields_valid == rhs.fields_valid;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::sick_safetyscanners::MonitoringCaseMsg_<ContainerAllocator1> & lhs, const ::sick_safetyscanners::MonitoringCaseMsg_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace sick_safetyscanners

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::sick_safetyscanners::MonitoringCaseMsg_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::sick_safetyscanners::MonitoringCaseMsg_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::sick_safetyscanners::MonitoringCaseMsg_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::sick_safetyscanners::MonitoringCaseMsg_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::sick_safetyscanners::MonitoringCaseMsg_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::sick_safetyscanners::MonitoringCaseMsg_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::sick_safetyscanners::MonitoringCaseMsg_<ContainerAllocator> >
{
  static const char* value()
  {
    return "df965c1c062890e5bdd7ee897e4f2d65";
  }

  static const char* value(const ::sick_safetyscanners::MonitoringCaseMsg_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xdf965c1c062890e5ULL;
  static const uint64_t static_value2 = 0xbdd7ee897e4f2d65ULL;
};

template<class ContainerAllocator>
struct DataType< ::sick_safetyscanners::MonitoringCaseMsg_<ContainerAllocator> >
{
  static const char* value()
  {
    return "sick_safetyscanners/MonitoringCaseMsg";
  }

  static const char* value(const ::sick_safetyscanners::MonitoringCaseMsg_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::sick_safetyscanners::MonitoringCaseMsg_<ContainerAllocator> >
{
  static const char* value()
  {
    return "int32 monitoring_case_number\n"
"int32[] fields\n"
"bool[] fields_valid\n"
;
  }

  static const char* value(const ::sick_safetyscanners::MonitoringCaseMsg_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::sick_safetyscanners::MonitoringCaseMsg_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.monitoring_case_number);
      stream.next(m.fields);
      stream.next(m.fields_valid);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct MonitoringCaseMsg_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::sick_safetyscanners::MonitoringCaseMsg_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::sick_safetyscanners::MonitoringCaseMsg_<ContainerAllocator>& v)
  {
    s << indent << "monitoring_case_number: ";
    Printer<int32_t>::stream(s, indent + "  ", v.monitoring_case_number);
    s << indent << "fields[]" << std::endl;
    for (size_t i = 0; i < v.fields.size(); ++i)
    {
      s << indent << "  fields[" << i << "]: ";
      Printer<int32_t>::stream(s, indent + "  ", v.fields[i]);
    }
    s << indent << "fields_valid[]" << std::endl;
    for (size_t i = 0; i < v.fields_valid.size(); ++i)
    {
      s << indent << "  fields_valid[" << i << "]: ";
      Printer<uint8_t>::stream(s, indent + "  ", v.fields_valid[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // SICK_SAFETYSCANNERS_MESSAGE_MONITORINGCASEMSG_H
