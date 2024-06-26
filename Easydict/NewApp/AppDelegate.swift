import Cocoa
import Combine

let kNotificationCloseStatusWindow = "kNotificationCloseStatusWindow"
let kNotificationOpenSettingWindow = "kNotificationOpenSettingWindow"

class AppDelegate: NSObject, NSApplicationDelegate {
    let windowWidth: CGFloat = 320
    var statusItem: NSStatusItem!
    var menuStatusToday: NSMenuItem!
    var menuStatusUpcome: NSMenuItem!
    var menuStatusSep0: NSMenuItem!
    var point: NSPoint?
    var statusBarWindow: NSWindow?
    var settingWindow: NSWindow?
    var isWindowShowed = false

    func applicationDidFinishLaunching(_: Notification) {
        MMCrash.registerHandler()
        EZLog.setupCrashService()
        EZLog.logAppInfo()
        NotificationCenter.default.addObserver(self, selector: #selector(closeMenu(_:)), name: Notification.Name(kNotificationCloseStatusWindow), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(clickSetting(_:)), name: Notification.Name(kNotificationOpenSettingWindow), object: nil)
        NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown]) { _ in
            if let window = self.statusBarWindow {
                if self.isWindowShowed {
                    window.close()
                    self.isWindowShowed = false
                }
            } else {
                debugPrint("xxxxx statusBarWindow null")
            }
        }
        openDefaultWindow(nil)
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        setMenuButtonImage()
        statusItem.button?.action = #selector(clickMenu)
    }

    func applicationShouldHandleReopen(_: NSApplication, hasVisibleWindows _: Bool) -> Bool {
        clickMenu(nil)
        return true
    }

    func applicationWillTerminate(_: Notification) {
        EZMenuItemManager.shared().remove()
    }

    func applicationShouldTerminateAfterLastWindowClosed(_: NSApplication) -> Bool {
        EZWindowManager.shared().closeMainWindowIfNeeded()
        return false
    }

    @objc func openDefaultWindow(_: Any?) {
        MenuView().createWindow(styleMask: [.fullSizeContentView], width: windowWidth, height: 330) { window in
            window.backgroundColor = NSColor.clear
            EZWindowManager.shared().statusBarWindow = window
            self.statusBarWindow = window
            self.showOrCloseWindow(window: window)
        }
    }

    @objc func closeMenu(_: Any?) {
        if let window = statusBarWindow {
            window.close()
            isWindowShowed = false
        } else {
            debugPrint("xxxxx statusBarWindow null")
        }
    }

    @objc func clickMenu(_: Any?) {
        if let window = statusBarWindow {
            showOrCloseWindow(window: window)
        } else {
            debugPrint("xxxxx statusBarWindow null")
        }
    }

    @objc func clickSetting(_: Any?) {
        guard let window = settingWindow else {
            if #available(macOS 13, *) {
                SettingView().createWindow { window in
                    self.settingWindow = window
                    window.center()
                    window.orderFront(nil)
                    if self.isWindowShowed {
                        self.isWindowShowed = false
                        self.statusBarWindow?.close()
                    }
                }
            }
            return
        }
        window.center()
        window.orderFront(nil)
        if isWindowShowed {
            isWindowShowed = false
            statusBarWindow?.close()
        }
    }

    func showOrCloseWindow(window: NSWindow) {
        if isWindowShowed {
            window.close()
            isWindowShowed = false
            return
        }
        if let point {
            window.setFrameOrigin(point)
            window.level = .floating
            window.orderFront(nil)
            isWindowShowed = true
            return
        }
        if statusItem == nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                self.showOrCloseWindow(window: window)
            }
            return
        }
        guard let sender = statusItem.button else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                self.showOrCloseWindow(window: window)
            }
            return
        }
        let rectInWindow = sender.convert(sender.bounds, to: nil)
        guard let screenRect = sender.window?.convertToScreen(rectInWindow) else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                self.showOrCloseWindow(window: window)
            }
            return
        }
        if screenRect.origin.x == NSScreen.main?.frame.size.width || screenRect.origin.x == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                self.showOrCloseWindow(window: window)
            }
        } else {
            let x = screenRect.origin.x + screenRect.size.width / 2 - windowWidth / 2
            let y = screenRect.origin.y
            point = NSPoint(x: x, y: y)
            window.setFrameOrigin(NSPoint(x: x, y: y))
            window.level = .floating
            window.orderFront(nil)
            isWindowShowed = true
        }
    }

    override func observeValue(forKeyPath _: String?, of _: Any?, change _: [NSKeyValueChangeKey: Any]?, context _: UnsafeMutableRawPointer?) {
        setMenuButtonImage()
    }

    func setMenuButtonImage() {
        if isDarkMode() {
            statusItem.button?.image = NSImage(named: "pawprint")
        } else {
            statusItem.button?.image = NSImage(named: "pawprint")
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
}
