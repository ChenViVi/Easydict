//
//  SettingView.swift
//  Easydict
//
//  Created by Kyle on 2023/12/29.
//  Copyright © 2023 izual. All rights reserved.
//

import SwiftUI

enum SettingTab: Int {
    case general
    case service
    case disabled
    case advanced
    case shortcut
    case about
}

struct SettingView: View {
    @State private var selection = SettingTab.general
    @State private var window: NSWindow?

    var body: some View {
        TabView(selection: $selection) {
            GeneralTab()
                .tabItem { Label("setting_general", systemImage: "gear") }
                .tag(SettingTab.general)

            ServiceTab()
                .tabItem { Label("service", systemImage: "briefcase") }
                .tag(SettingTab.service)

            DisabledAppTab()
                .tabItem { Label("disabled_app_list", systemImage: "nosign") }
                .tag(SettingTab.disabled)

            ShortcutTab()
                .tabItem { Label("shortcut", systemImage: "command.square") }
                .tag(SettingTab.shortcut)

            AdvancedTab()
                .tabItem { Label("advanced", systemImage: "gearshape.2") }
                .tag(SettingTab.advanced)

            AboutTab()
                .tabItem { Label("about", systemImage: "info.bubble") }
                .tag(SettingTab.about)
        }
        .background(
            WindowAccessor(window: $window.didSet(execute: { _ in
                // reset frame when first launch
                resizeWindowFrame()
            }))
        )
        .onChange(of: selection) { _ in
            resizeWindowFrame()
        }
    }

    func resizeWindowFrame() {
        guard let window else { return }

        // Disable zoom button, refer: https://stackoverflow.com/a/66039864/8378840
        window.standardWindowButton(.zoomButton)?.isEnabled = false

        // Keep the settings page windows all the same width to avoid strange animations.
        let maxWidth = 780
        let height = switch selection {
        case .disabled:
            500
        case .advanced:
            400
        case .about:
            320
        default:
            maxWidth - 110
        }

        let newSize = CGSize(width: maxWidth, height: height)

        let originalFrame = window.frame
        let newY = originalFrame.origin.y + originalFrame.size.height - newSize.height
        let newRect = NSRect(origin: CGPoint(x: originalFrame.origin.x, y: newY), size: newSize)

        window.setFrame(newRect, display: true, animate: true)
    }
}

#Preview {
    SettingView()
}
