//
//  ShortcutTab.swift
//  Easydict
//
//  Created by Sharker on 2024/1/21.
//  Copyright © 2024 izual. All rights reserved.
//

import SwiftUI

struct ShortcutTab: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Form {
                    // Global shortcut
                    GlobalShortcutSettingView()
                    // In app shortcut
                    AppShortcutSettingView()
                }
                // .formStyle(.grouped)
            }
            .padding()
        }
    }
}

#Preview {
    ShortcutTab()
}
