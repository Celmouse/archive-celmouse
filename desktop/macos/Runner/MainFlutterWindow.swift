import Cocoa
import CoreGraphics
import FlutterMacOS

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
            switch call.method {
            case "moveTo":
                if let arguments = call.arguments as? [String: Double],
                    let x = arguments["x"],
                    let y = arguments["y"]
                {
                    mouseController.moveTo(to: CGPoint(x: x, y: y))

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
            case "move":
                if let arguments = call.arguments as? [String: Double],
                    let x = arguments["x"],
                    let y = arguments["y"]
                {

                    mouseController.move(x: x, y: y)

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
            case "scroll":
                if let arguments = call.arguments as? [String: Double],
                    let x = arguments["x"],
                    let y = arguments["y"]
                {

                    mouseController.scroll(x: x, y: y)

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
            case "click":
                if let arguments = call.arguments as? Int {
                    mouseController.click(button: arguments)
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
            case "doubleClick":
                mouseController.doubleClick()
                result(nil)
            case "holdButton":
                if let arguments = call.arguments as? Int {
                    mouseController.holdButton(button: arguments)
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
            case "releaseButton":
                if let arguments = call.arguments as? Int {
                    mouseController.releaseButton(button: arguments)
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
            //            case "screenSize":
            //                result(self.screenSize())
            default:
                result(FlutterMethodNotImplemented)
            }
        }

        RegisterGeneratedPlugins(registry: flutterViewController)

        super.awakeFromNib()
    }

    //    func screenSize() -> [String : Double] {
    //        let screenSize: CGRect = UIScreen.main.bounds
    //        let coordinates = [:]
    //        coordinates["x"] = screenSize.size.width
    //        coordinates["y"] = screenSize.size.height
    //        return coordinates
    //    }
}
