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

    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
