//
//  EasydictApp.swift
//  Easydict
//
//  Created by Kyle on 2023/12/28.
//  Copyright © 2023 izual. All rights reserved.
//

import Defaults
import Sparkle
import SwiftUI

// @main
// enum EasydictCmpatibilityEntry {
//    static func main() {
//        EasydictApp.main()
//    }
// }
@main
struct EasydictApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

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
