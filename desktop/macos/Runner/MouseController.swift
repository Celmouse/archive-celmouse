//
//  MouseController.swift
//  Runner
//
//  Created by marcelo viana on 19/01/25.
//
import Cocoa


class MouseController {
    
    func moveTo(to point: CGPoint)  {
        if let event = CGEvent(
            mouseEventSource: nil,
            mouseType: .mouseMoved,
            mouseCursorPosition: point,
            mouseButton: .left
        ) {
            event.post(tap: .cghidEventTap)
        }
    }
    
    func move(x: Double, y: Double) {
        print("Testando isso aqui")
        if let event = CGEvent(source: nil) {
            let currentMousePosition = event.location
            
            // Calculate the new position
            let newX = currentMousePosition.x + CGFloat(x)
            let newY = currentMousePosition.y + CGFloat(y)
            
            let mouseEvent: CGEventType = .mouseMoved
            
            if let moveEvent = CGEvent(
                mouseEventSource: nil,
                mouseType: mouseEvent,
                mouseCursorPosition: CGPoint(x: newX, y: newY),
                mouseButton: .left
            ) {
                moveEvent.post(tap: .cghidEventTap)
            }
        }
    }
    
    func scroll(x: Double, y: Double) {
        print("Testando isso aqui")
        if let event = CGEvent(source: nil) {
            let currentMousePosition = event.location
            
            // Calculate the new position
            let newX = currentMousePosition.x + CGFloat(x)
            let newY = currentMousePosition.y + CGFloat(y)
            
            let mouseEvent: CGEventType = .scrollWheel
            
            if let moveEvent = CGEvent(
                mouseEventSource: nil,
                mouseType: mouseEvent,
                mouseCursorPosition: CGPoint(x: newX, y: newY),
                mouseButton: .left
            ) {
                moveEvent.post(tap: .cghidEventTap)
            }
        }
    }
    
    func click(button: Int) {
        let mouseButton: CGMouseButton
        let mousePressEventType: CGEventType
        let mouseReleaseEventType: CGEventType
        
        // Determine the button and event type based on the input value
        switch button {
        case 0:
            mouseButton = .left
            mousePressEventType = .leftMouseDown
            mouseReleaseEventType = .leftMouseUp
        case 1:
            mouseButton = .right
            mousePressEventType = .rightMouseDown
            mouseReleaseEventType = .rightMouseUp
        default:
            print(
                "Invalid button value. Use 0 for left button or 1 for right button."
            )
            return
        }
        
        // Get the current mouse position
        if let event = CGEvent(source: nil) {
            let currentMousePosition = event.location
            
            // Create a mouse down event
            if let mouseDownEvent = CGEvent(
                mouseEventSource: nil,
                mouseType: mousePressEventType,
                mouseCursorPosition: currentMousePosition,
                mouseButton: mouseButton
            ) {
                // Create a mouse up event
                if let mouseUpEvent = CGEvent(
                    mouseEventSource: nil,
                    mouseType: mouseReleaseEventType,
                    mouseCursorPosition: currentMousePosition,
                    mouseButton: mouseButton
                ) {
                    // Post the mouse down and mouse up events
                    mouseDownEvent.post(tap: .cghidEventTap)
                    mouseUpEvent.post(tap: .cghidEventTap)
                }
            }
        }
    }
    
    func doubleClick(){
        self.click(button: 0);
        self.click(button: 0);
    }
    
    func holdButton(button: Int) {
        let mouseButton: CGMouseButton
        let mouseEventType: CGEventType
        
        // Determine the button and event type based on the input value
        switch button {
        case 0:
            mouseButton = .left
            mouseEventType = .leftMouseDragged
        case 1:
            mouseButton = .right
            mouseEventType = .rightMouseDragged
        default:
            print(
                "Invalid button value. Use 0 for left button or 1 for right button."
            )
            return
        }
        
        // Get the current mouse position
        if let event = CGEvent(source: nil) {
            let currentMousePosition = event.location
            
            // Create and post the mouse down event
            if let mouseDownEvent = CGEvent(
                mouseEventSource: nil,
                mouseType: mouseEventType,
                mouseCursorPosition: currentMousePosition,
                mouseButton: mouseButton
            ) {
                mouseDownEvent.post(tap: .cghidEventTap)
            }
        }
    }
    
    // Method to release the mouse button
    func releaseButton(button: Int) {
        let mouseButton: CGMouseButton
        let mouseEventType: CGEventType
        
        // Determine the button and event type based on the input value
        switch button {
        case 0:
            mouseButton = .left
            mouseEventType = .leftMouseUp
        case 1:
            mouseButton = .right
            mouseEventType = .rightMouseUp
        default:
            print(
                "Invalid button value. Use 0 for left button or 1 for right button."
            )
            return
        }
        
        // Get the current mouse position
        if let event = CGEvent(source: nil) {
            let currentMousePosition = event.location
            
            // Create and post the mouse up event
            if let mouseUpEvent = CGEvent(
                mouseEventSource: nil,
                mouseType: mouseEventType,
                mouseCursorPosition: currentMousePosition,
                mouseButton: mouseButton
            ) {
                mouseUpEvent.post(tap: .cghidEventTap)
            }
        }
    }
}
