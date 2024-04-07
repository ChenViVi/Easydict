//
//  EasydictApp.swift
//  CalendarSwiftUI
//
//  Created by mbp15 on 2024/1/31.
//

import Defaults
import SwiftUI

@main
struct EasydictApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage(Defaults.Key<Bool>.hideMenuBarIcon.name)
    private var hideMenuBar = Defaults.Key<Bool>.hideMenuBarIcon.defaultValue

    @Default(.selectedMenuBarIcon)
    private var menuBarIcon

    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

extension Bool {
    var toggledValue: Bool {
        get { !self }
        mutating set { self = newValue.toggledValue }
    }
}

enum MenuBarIconType: String, CaseIterable, Defaults.Serializable, Identifiable {
    var id: Self { self }

    case square = "square_menu_bar_icon"
    case rounded = "rounded_menu_bar_icon"
}
