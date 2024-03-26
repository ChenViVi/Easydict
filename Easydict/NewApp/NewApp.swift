import Cocoa
import Combine
import SwiftUI

let kNotificationOpenStatusWindow = "kNotificationOpenStatusWindow"

private final class WindowDelegate: NSObject, NSWindowDelegate {
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        NSApp.removeWindowsItem(sender)
        return true
    }

    deinit {
        NSLog("deallocated ...")
    }
}

class NewApp: NSObject, NSApplicationDelegate {
    let windowWidth: CGFloat = 320
    var statusItem: NSStatusItem!
    var menuStatusToday: NSMenuItem!
    var menuStatusUpcome: NSMenuItem!
    var menuStatusSep0: NSMenuItem!
    var timer: Timer!
    var point: NSPoint?
    var statusBarWindow: NSWindow
    var isWindowShowed = false

    override init() {
        let windowDelegate = WindowDelegate()
        statusBarWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: windowWidth, height: 460),
            styleMask: [.fullSizeContentView],
            backing: .buffered, defer: false
        )
        statusBarWindow.titlebarAppearsTransparent = true
        statusBarWindow.isReleasedWhenClosed = false
        statusBarWindow.title = ""
        // who owns who :-)
        statusBarWindow.delegate = windowDelegate
        statusBarWindow.contentView = NSHostingView(rootView: MenuView())
        statusBarWindow.backgroundColor = NSColor.clear
    }

    func applicationDidFinishLaunching(_: Notification) {
        NotificationCenter.default.addObserver(self, selector: #selector(clickMenu(_:)), name: Notification.Name(kNotificationOpenStatusWindow), object: nil)
        NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown]) { _ in
            if self.isWindowShowed {
                self.statusBarWindow.close()
                self.isWindowShowed = false
            }
        }
        print("xxxxxxxx ???? 1")
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        setMenuButtonImage()
        statusItem.button?.action = #selector(clickMenu)
        clickMenu(nil)
    }

    func applicationShouldHandleReopen(_: NSApplication, hasVisibleWindows _: Bool) -> Bool {
        clickMenu(nil)
        return true
    }

    @objc func clickMenu(_: Any?) {
        showOrCloseWindow()
    }

    func showOrCloseWindow() {
        if isWindowShowed {
            statusBarWindow.close()
            isWindowShowed = false
            return
        }
        if let point {
            statusBarWindow.setFrameOrigin(point)
            statusBarWindow.level = .floating
            statusBarWindow.orderFront(nil)
            isWindowShowed = true
            return
        }
        if statusItem == nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                self.showOrCloseWindow()
            }
            return
        }
        guard let sender = statusItem.button else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                self.showOrCloseWindow()
            }
            return
        }
        let rectInWindow = sender.convert(sender.bounds, to: nil)
        guard let screenRect = sender.window?.convertToScreen(rectInWindow) else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                self.showOrCloseWindow()
            }
            return
        }
        if screenRect.origin.x == NSScreen.main?.frame.size.width || screenRect.origin.x == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                self.showOrCloseWindow()
            }
        } else {
            let x = screenRect.origin.x + screenRect.size.width / 2 - windowWidth / 2
            let y = screenRect.origin.y
            point = NSPoint(x: x, y: y)
            statusBarWindow.setFrameOrigin(NSPoint(x: x, y: y))
            statusBarWindow.level = .floating
            statusBarWindow.orderFront(nil)
            isWindowShowed = true
        }
    }

    override func observeValue(forKeyPath _: String?, of _: Any?, change _: [NSKeyValueChangeKey: Any]?, context _: UnsafeMutableRawPointer?) { setMenuButtonImage()
    }

    func setMenuButtonImage() {
        if isDarkMode() {
            statusItem.button?.image = NSImage(named: "square_menu_bar_icon")
        } else {
            statusItem.button?.image = NSImage(named: "square_menu_bar_icon")
        }
    }

    func isDarkMode() -> Bool {
        if #available(macOS 10.14, *) {
            return (statusItem.button?.effectiveAppearance.name == NSAppearance.Name.darkAqua ||
                statusItem.button?.effectiveAppearance.name == NSAppearance.Name.vibrantDark ||
                statusItem.button?.effectiveAppearance.name == NSAppearance.Name.accessibilityHighContrastDarkAqua ||
                statusItem.button?.effectiveAppearance.name == NSAppearance.Name.accessibilityHighContrastVibrantDark)
        }
        return statusItem.button?.effectiveAppearance.name == NSAppearance.Name.vibrantDark
    }

    deinit {
        self.timer.invalidate()
    }
}