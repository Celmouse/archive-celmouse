enum MouseButton {
  /* For MacOS see:
  
  // Constants that specify buttons on a one, two, or three-button mouse. 
  typedef CF_ENUM(uint32_t, CGMouseButton) {
    kCGMouseButtonLeft = 0,
    kCGMouseButtonRight = 1,
    kCGMouseButtonCenter = 2
  };
  */
  left(0),
  right(1),
  middle(2);

  const MouseButton(this.value);
  final int value;
}
