import FlutterMacOS
import Cocoa
import CoreGraphics


class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)
    
      let mouseChannel = FlutterMethodChannel(
          name: "com.celmouse.plugins/mouse",
          binaryMessenger: flutterViewController.engine.binaryMessenger
      )

      mouseChannel.setMethodCallHandler { (call, result) in
        switch call.method {
          case "move":
            if let arguments = call.arguments as? [String: Double],
              let x = arguments["x"],
              let y = arguments["y"] {
              let coordinates =  self.moveMousePointer(to: CGPoint(x: x, y: y))
              result(coordinates)
            } else {
              result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
            }
          case "moveRelative":
            if let arguments = call.arguments as? [String: Double],
              let x = arguments["x"],
              let y = arguments["y"] {
              let coordinates =  self.moveMousePointerRelative(to: CGPoint(x: x, y: y));                           result(coordinates)
            } else {
              result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
            }
          default:
            result(FlutterMethodNotImplemented)
        }
      }

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }

   func moveMousePointer(to point: CGPoint) -> [String: Double]? {
      
    // if let event = CGEvent(mouseEventSource: nil, mouseType: .mouseMoved, mouseCursorPosition: point, mouseButton: .left) {
    //     event.post(tap: .cghidEventTap)
    // }
    // print(point)
    
    // // Note: NSEvent.mouseLocation's origin is at the bottom-left of the main screen,
    // // while Quartz uses a top-left origin. Adjust Y-coordinate accordingly.
    // mousePosition.y = NSScreen.main?.frame.height ?? 0 - mousePosition.y

    let mousePosition = NSEvent.mouseLocation
    
    var coordinates: [String: Double] = [:]
    coordinates["x"] = mousePosition.x
    coordinates["y"] = mousePosition.y
    return coordinates
  }
    
   func moveMousePointerRelative(to point: CGPoint) -> [String: Double]? {
      let mousePosition = NSEvent.mouseLocation
      let x = point.x + mousePosition.x
      let y = point.y + mousePosition.y
      let relativePoint = CGPoint(x: x, y: y)
      
      if let event = CGEvent(mouseEventSource: nil, mouseType: .mouseMoved, mouseCursorPosition: relativePoint, mouseButton: .left) {
          event.post(tap: .cghidEventTap)
      }
      
      var coordinates: [String: Double] = [:]
      coordinates["x"] = x
      coordinates["y"] = y
      return coordinates
  }
}
