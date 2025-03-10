# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from motor_controller/motorfeedback.msg. Do not edit."""
import codecs
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct


class motorfeedback(genpy.Message):
  _md5sum = "8dc03d848f56907041b4a626e48c93fa"
  _type = "motor_controller/motorfeedback"
  _has_header = False  # flag to mark the presence of a Header object
  _full_text = """float32 rotates
float32 speed
int16 left_wheel_tickes
int16 right_wheel_tickes

"""
  __slots__ = ['rotates','speed','left_wheel_tickes','right_wheel_tickes']
  _slot_types = ['float32','float32','int16','int16']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       rotates,speed,left_wheel_tickes,right_wheel_tickes

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(motorfeedback, self).__init__(*args, **kwds)
      # message fields cannot be None, assign default values for those that are
      if self.rotates is None:
        self.rotates = 0.
      if self.speed is None:
        self.speed = 0.
      if self.left_wheel_tickes is None:
        self.left_wheel_tickes = 0
      if self.right_wheel_tickes is None:
        self.right_wheel_tickes = 0
    else:
      self.rotates = 0.
      self.speed = 0.
      self.left_wheel_tickes = 0
      self.right_wheel_tickes = 0

  def _get_types(self):
    """
    internal API method
    """
    return self._slot_types

  def serialize(self, buff):
    """
    serialize message into buffer
    :param buff: buffer, ``StringIO``
    """
    try:
      _x = self
      buff.write(_get_struct_2f2h().pack(_x.rotates, _x.speed, _x.left_wheel_tickes, _x.right_wheel_tickes))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    :param str: byte array of serialized message, ``str``
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      end = 0
      _x = self
      start = end
      end += 12
      (_x.rotates, _x.speed, _x.left_wheel_tickes, _x.right_wheel_tickes,) = _get_struct_2f2h().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill


  def serialize_numpy(self, buff, numpy):
    """
    serialize message with numpy array types into buffer
    :param buff: buffer, ``StringIO``
    :param numpy: numpy python module
    """
    try:
      _x = self
      buff.write(_get_struct_2f2h().pack(_x.rotates, _x.speed, _x.left_wheel_tickes, _x.right_wheel_tickes))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    :param str: byte array of serialized message, ``str``
    :param numpy: numpy python module
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      end = 0
      _x = self
      start = end
      end += 12
      (_x.rotates, _x.speed, _x.left_wheel_tickes, _x.right_wheel_tickes,) = _get_struct_2f2h().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill

_struct_I = genpy.struct_I
def _get_struct_I():
    global _struct_I
    return _struct_I
_struct_2f2h = None
def _get_struct_2f2h():
    global _struct_2f2h
    if _struct_2f2h is None:
        _struct_2f2h = struct.Struct("<2f2h")
    return _struct_2f2h
