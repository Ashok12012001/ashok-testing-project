// Auto-generated. Do not edit!

// (in-package motor_controller.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class motorfeedback {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.rotates = null;
      this.speed = null;
      this.left_wheel_tickes = null;
      this.right_wheel_tickes = null;
    }
    else {
      if (initObj.hasOwnProperty('rotates')) {
        this.rotates = initObj.rotates
      }
      else {
        this.rotates = 0.0;
      }
      if (initObj.hasOwnProperty('speed')) {
        this.speed = initObj.speed
      }
      else {
        this.speed = 0.0;
      }
      if (initObj.hasOwnProperty('left_wheel_tickes')) {
        this.left_wheel_tickes = initObj.left_wheel_tickes
      }
      else {
        this.left_wheel_tickes = 0;
      }
      if (initObj.hasOwnProperty('right_wheel_tickes')) {
        this.right_wheel_tickes = initObj.right_wheel_tickes
      }
      else {
        this.right_wheel_tickes = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type motorfeedback
    // Serialize message field [rotates]
    bufferOffset = _serializer.float32(obj.rotates, buffer, bufferOffset);
    // Serialize message field [speed]
    bufferOffset = _serializer.float32(obj.speed, buffer, bufferOffset);
    // Serialize message field [left_wheel_tickes]
    bufferOffset = _serializer.int16(obj.left_wheel_tickes, buffer, bufferOffset);
    // Serialize message field [right_wheel_tickes]
    bufferOffset = _serializer.int16(obj.right_wheel_tickes, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type motorfeedback
    let len;
    let data = new motorfeedback(null);
    // Deserialize message field [rotates]
    data.rotates = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [speed]
    data.speed = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [left_wheel_tickes]
    data.left_wheel_tickes = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [right_wheel_tickes]
    data.right_wheel_tickes = _deserializer.int16(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'motor_controller/motorfeedback';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '8dc03d848f56907041b4a626e48c93fa';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 rotates
    float32 speed
    int16 left_wheel_tickes
    int16 right_wheel_tickes
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new motorfeedback(null);
    if (msg.rotates !== undefined) {
      resolved.rotates = msg.rotates;
    }
    else {
      resolved.rotates = 0.0
    }

    if (msg.speed !== undefined) {
      resolved.speed = msg.speed;
    }
    else {
      resolved.speed = 0.0
    }

    if (msg.left_wheel_tickes !== undefined) {
      resolved.left_wheel_tickes = msg.left_wheel_tickes;
    }
    else {
      resolved.left_wheel_tickes = 0
    }

    if (msg.right_wheel_tickes !== undefined) {
      resolved.right_wheel_tickes = msg.right_wheel_tickes;
    }
    else {
      resolved.right_wheel_tickes = 0
    }

    return resolved;
    }
};

module.exports = motorfeedback;
