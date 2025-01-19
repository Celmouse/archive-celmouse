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
        
        let mouseController = MouseController()
        
        mouseChannel.setMethodCallHandler { (call, result) in
            print("Entrou")
            switch call.method {
            case "move":
                if let arguments = call.arguments as? [String: Double],
                   let x = arguments["x"],
                   let y = arguments["y"] {
                    mouseController.moveMousePointer(to: CGPoint(x: x, y: y))
                    
                    result(nil)
                } else {
                    result(
                        FlutterError(
                            code: "INVALID_ARGUMENTS",
                            message: "Invalid arguments",
                            details: nil
                        )
                    )
                }
            case "moveRelative":
                if let arguments = call.arguments as? [String: Double],
                   let x = arguments["x"],
                   let y = arguments["y"] {
                    
                    mouseController.moveMousePointerRelative(x: x, y: y);
                    
                    result(nil)
                } else {
                    result(
                        FlutterError(
                            code: "INVALID_ARGUMENTS",
                            message: "Invalid arguments",
                            details: nil
                        )
                    )
                }
            case "tapButton":
                if let arguments = call.arguments as? Int {
                    mouseController.tapMouseButton(button: arguments)
                    result(nil)
                }
                
                else {
                    result(
                        FlutterError(
                            code: "INVALID_ARGUMENTS",
                            message: "Invalid arguments",
                            details: nil
                        )
                    )
                }
            case "holdButton":
                if let arguments = call.arguments as? Int {
                    mouseController.holdMouseButton(button: arguments)
                    result(nil)
                }
                
                else {
                    result(
                        FlutterError(
                            code: "INVALID_ARGUMENTS",
                            message: "Invalid arguments",
                            details: nil
                        )
                    )
                }
            case "releaseButton":
                if let arguments = call.arguments as? Int {
                    mouseController.releaseMouseButton(button: arguments)
                    result(nil)
                }
                
                else {
                    result(
                        FlutterError(
                            code: "INVALID_ARGUMENTS",
                            message: "Invalid arguments",
                            details: nil
                        )
                    )
                }
            default:
                result(FlutterMethodNotImplemented)
            }
        }
        
        RegisterGeneratedPlugins(registry: flutterViewController)
        
        super.awakeFromNib()
    }
    
}
