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

@main
enum EasydictCmpatibilityEntry {
    static func main() {
        EasydictApp.main()
    }
}

struct EasydictApp: App {
    // Use `@Default` will cause a purple warning and continuously call `set` of it.
    // I'm not sure why. Just leave `AppStorage` here.
    @State var hideMenuBar: Bool = true

    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        Settings {
            EmptyView()
        }
//        if #available(macOS 13, *) {
//            MenuBarExtra(isInserted: $hideMenuBar) {
//                MenuView()
//            } label: {
//                Label {
//                    Text("Easydict")
//                } icon: {
//                    Image("pawprint")
//                }
//            }
//            // .menuBarExtraStyle(.window)
//            .menuBarExtraStyle(.menu)
//        }
    }
}
