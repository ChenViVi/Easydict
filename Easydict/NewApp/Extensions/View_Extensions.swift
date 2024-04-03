//
//  View_Extensions.swift
//  GDriveSwiftUI
//
//  Created by cimi on 2024/1/5.
//

import SwiftUI

/**
 hack to avoid crashes on window close, and remove the window from the
 NSApplication stack, ie: avoid leaking window objects
 */
private final class WindowDelegate: NSObject, NSWindowDelegate {
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        NSApp.removeWindowsItem(sender)
        return true
    }

    deinit {
        NSLog("deallocated ...")
    }
}

public extension View {
    func createWindow(styleMask: NSWindow.StyleMask = [.titled, .closable, .miniaturizable, .fullSizeContentView], width: CGFloat = 340, height: CGFloat = 460, introspect: @escaping (_ window: NSWindow) -> Void) {
        let windowDelegate = WindowDelegate()
        let rv = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: width, height: height),
            styleMask: styleMask,
            backing: .buffered, defer: false
        )
        rv.titlebarAppearsTransparent = true
        rv.isReleasedWhenClosed = false
        rv.title = ""
        // who owns who :-)
        rv.delegate = windowDelegate
        rv.contentView = NSHostingView(rootView: self)
        // rv.backgroundColor = NSColor.clear
        introspect(rv)
    }
}
