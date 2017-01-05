import UIKit
import Foundation

class TestAppDelegate: NSObject, UIApplicationDelegate {}

let className: String
if NSClassFromString("XCTest") != nil {
    className = NSStringFromClass(TestAppDelegate.self)
} else {
    className = NSStringFromClass(AppDelegate.self)
}

autoreleasepool {
    _ = CommandLine.unsafeArgv.withMemoryRebound(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc)) { argv in
        UIApplicationMain(CommandLine.argc, argv, nil, className)
    }
}
