// Auto-generated. Do not edit!

// (in-package server_project.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let sensor_msgs = _finder('sensor_msgs');

//-----------------------------------------------------------


//-----------------------------------------------------------

class ImageRotationRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.input_image = null;
      this.rotation_angle = null;
    }
    else {
      if (initObj.hasOwnProperty('input_image')) {
        this.input_image = initObj.input_image
      }
      else {
        this.input_image = new sensor_msgs.msg.Image();
      }
      if (initObj.hasOwnProperty('rotation_angle')) {
        this.rotation_angle = initObj.rotation_angle
      }
      else {
        this.rotation_angle = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ImageRotationRequest
    // Serialize message field [input_image]
    bufferOffset = sensor_msgs.msg.Image.serialize(obj.input_image, buffer, bufferOffset);
    // Serialize message field [rotation_angle]
    bufferOffset = _serializer.float64(obj.rotation_angle, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ImageRotationRequest
    let len;
    let data = new ImageRotationRequest(null);
    // Deserialize message field [input_image]
    data.input_image = sensor_msgs.msg.Image.deserialize(buffer, bufferOffset);
    // Deserialize message field [rotation_angle]
    data.rotation_angle = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += sensor_msgs.msg.Image.getMessageSize(object.input_image);
    return length + 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'server_project/ImageRotationRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '02a02f38cfe78c5e0f4be8640bf4808e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    sensor_msgs/Image input_image
    float64 rotation_angle
    
    ================================================================================
    MSG: sensor_msgs/Image
    # This message contains an uncompressed image
    # (0, 0) is at top-left corner of image
    #
    
    Header header        # Header timestamp should be acquisition time of image
                         # Header frame_id should be optical frame of camera
                         # origin of frame should be optical center of camera
                         # +x should point to the right in the image
                         # +y should point down in the image
                         # +z should point into to plane of the image
                         # If the frame_id here and the frame_id of the CameraInfo
                         # message associated with the image conflict
                         # the behavior is undefined
    
    uint32 height         # image height, that is, number of rows
    uint32 width          # image width, that is, number of columns
    
    # The legal values for encoding are in file src/image_encodings.cpp
    # If you want to standardize a new string format, join
    # ros-users@lists.sourceforge.net and send an email proposing a new encoding.
    
    string encoding       # Encoding of pixels -- channel meaning, ordering, size
                          # taken from the list of strings in include/sensor_msgs/image_encodings.h
    
    uint8 is_bigendian    # is this data bigendian?
    uint32 step           # Full row length in bytes
    uint8[] data          # actual matrix data, size is (step * rows)
    
    ================================================================================
    MSG: std_msgs/Header
    # Standard metadata for higher-level stamped data types.
    # This is generally used to communicate timestamped data 
    # in a particular coordinate frame.
    # 
    # sequence ID: consecutively increasing ID 
    uint32 seq
    #Two-integer timestamp that is expressed as:
    # * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
    # * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
    # time-handling sugar is provided by the client library
    time stamp
    #Frame this data is associated with
    string frame_id
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ImageRotationRequest(null);
    if (msg.input_image !== undefined) {
      resolved.input_image = sensor_msgs.msg.Image.Resolve(msg.input_image)
    }
    else {
      resolved.input_image = new sensor_msgs.msg.Image()
    }

    if (msg.rotation_angle !== undefined) {
      resolved.rotation_angle = msg.rotation_angle;
    }
    else {
      resolved.rotation_angle = 0.0
    }

    return resolved;
    }
};

class ImageRotationResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.output_image = null;
    }
    else {
      if (initObj.hasOwnProperty('output_image')) {
        this.output_image = initObj.output_image
      }
      else {
        this.output_image = new sensor_msgs.msg.Image();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ImageRotationResponse
    // Serialize message field [output_image]
    bufferOffset = sensor_msgs.msg.Image.serialize(obj.output_image, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ImageRotationResponse
    let len;
    let data = new ImageRotationResponse(null);
    // Deserialize message field [output_image]
    data.output_image = sensor_msgs.msg.Image.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += sensor_msgs.msg.Image.getMessageSize(object.output_image);
    return length;
  }

  static datatype() {
    // Returns string type for a service object
    return 'server_project/ImageRotationResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6f1c3b208183f95adfb208a50d8ac3fc';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    sensor_msgs/Image output_image
    
    
    
    ================================================================================
    MSG: sensor_msgs/Image
    # This message contains an uncompressed image
    # (0, 0) is at top-left corner of image
    #
    
    Header header        # Header timestamp should be acquisition time of image
                         # Header frame_id should be optical frame of camera
                         # origin of frame should be optical center of camera
                         # +x should point to the right in the image
                         # +y should point down in the image
                         # +z should point into to plane of the image
                         # If the frame_id here and the frame_id of the CameraInfo
                         # message associated with the image conflict
                         # the behavior is undefined
    
    uint32 height         # image height, that is, number of rows
    uint32 width          # image width, that is, number of columns
    
    # The legal values for encoding are in file src/image_encodings.cpp
    # If you want to standardize a new string format, join
    # ros-users@lists.sourceforge.net and send an email proposing a new encoding.
    
    string encoding       # Encoding of pixels -- channel meaning, ordering, size
                          # taken from the list of strings in include/sensor_msgs/image_encodings.h
    
    uint8 is_bigendian    # is this data bigendian?
    uint32 step           # Full row length in bytes
    uint8[] data          # actual matrix data, size is (step * rows)
    
    ================================================================================
    MSG: std_msgs/Header
    # Standard metadata for higher-level stamped data types.
    # This is generally used to communicate timestamped data 
    # in a particular coordinate frame.
    # 
    # sequence ID: consecutively increasing ID 
    uint32 seq
    #Two-integer timestamp that is expressed as:
    # * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
    # * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
    # time-handling sugar is provided by the client library
    time stamp
    #Frame this data is associated with
    string frame_id
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ImageRotationResponse(null);
    if (msg.output_image !== undefined) {
      resolved.output_image = sensor_msgs.msg.Image.Resolve(msg.output_image)
    }
    else {
      resolved.output_image = new sensor_msgs.msg.Image()
    }

    return resolved;
    }
};

module.exports = {
  Request: ImageRotationRequest,
  Response: ImageRotationResponse,
  md5sum() { return '9819b8903a9f0ce8015de560a2f07e7e'; },
  datatype() { return 'server_project/ImageRotation'; }
};
