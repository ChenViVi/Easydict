//
//  GlobalShortcutSetting.swift
//  Easydict
//
//  Created by Sharker on 2024/1/1.
//  Copyright © 2024 izual. All rights reserved.
//

import SwiftUI

extension ShortcutTab {
    struct GlobalShortcutSettingView: View {
        @State var confictAlterMessage: ShortcutConfictAlertMessage = .init(title: "", message: "")
        @State private var shortcutDataList = [
            KeyHolderDataItem(type: .inputTranslate),
            KeyHolderDataItem(type: .snipTranslate),
            KeyHolderDataItem(type: .selectTranslate),
            KeyHolderDataItem(type: .showMiniWindow),
            KeyHolderDataItem(type: .silentScreenshotOcr),
        ]
        var body: some View {
            let showAlter = Binding<Bool>(
                get: {
                    !confictAlterMessage.message.isEmpty
                }, set: { _ in
                }
            )
            Section {
                ForEach(shortcutDataList) { item in
                    KeyHolderRowView(title: item.type.localizedStringKey(), type: item.type, confictAlterMessage: $confictAlterMessage)
                }
            } header: {
                Text("global_shortcut_setting")
            }

            .alert(String(localized: "shortcut_confict \(confictAlterMessage.title)"),
                   isPresented: showAlter,
                   presenting: confictAlterMessage)
            { _ in
                Button("Confirm") {
                    confictAlterMessage = ShortcutConfictAlertMessage(title: "", message: "")
                }
            } message: { message in
                Text(message.message)
            }
        }
    }
}
