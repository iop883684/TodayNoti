import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {}

class WindowController: NSWindowController {
    override func windowDidLoad() {
        self.window?.standardWindowButton(.closeButton)?.superview?.isHidden = true
        self.window?.level = .modalPanel
    }

    /*
     public static let normal: NSWindow.Level
     
     public static let floating: NSWindow.Level
     
     public static let submenu: NSWindow.Level
     
     public static let tornOffMenu: NSWindow.Level
     
     public static let mainMenu: NSWindow.Level
     
     public static let statusBar: NSWindow.Level
     
     @available(OSX, introduced: 10.0, deprecated: 10.13)
     public static let dock: NSWindow.Level
     
     public static let modalPanel: NSWindow.Level
     
     public static let popUpMenu: NSWindow.Level
     
     public static let screenSaver: NSWindow.Level
     */
    
}
