//
//  MenuView.swift
//  Easydict
//
//  Created by mbp15 on 2024/3/26.
//  Copyright © 2024 izual. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            VStack {
                Button(action: {
                    NotificationCenter.default.post(name: Notification.Name(kNotificationCloseStatusWindow), object: nil)
                    EZWindowManager.shared().inputTranslate(false)
                }) {
                    HStack {
                        ZStack {
                            Color.accentColor
                            Image(systemName: "keyboard").foregroundColor(.white)
                        }
                        .cornerRadius(13)
                        .frame(width: 26, height: 26)
                        VStack(alignment: .leading) {
                            Text("Input Translate")
                                .font(.headline)
                                .fontWeight(.regular)
                                .foregroundColor(Color.primary)
                            Text("⎇ A")
                                .font(.subheadline)
                                .foregroundColor(Color.secondary)
                        }
                        Spacer()
                    }
                }
                .buttonStyle(.plain)
                Button(action: {
                    NotificationCenter.default.post(name: Notification.Name(kNotificationCloseStatusWindow), object: nil)
                    EZWindowManager.shared().snipTranslate()
                }) {
                    HStack {
                        ZStack {
                            Color.accentColor
                            Image(systemName: "camera.viewfinder").foregroundColor(.white)
                        }
                        .cornerRadius(13)
                        .frame(width: 26, height: 26)
                        VStack(alignment: .leading) {
                            Text("Screenshot Translate")
                                .font(.headline)
                                .fontWeight(.regular)
                                .foregroundColor(Color.primary)
                            Text("⎇ S")
                                .font(.subheadline)
                                .foregroundColor(Color.secondary)
                        }
                        Spacer()
                    }
                }
                .buttonStyle(.plain)
                Button(action: {
                    NotificationCenter.default.post(name: Notification.Name(kNotificationCloseStatusWindow), object: nil)
                    EZWindowManager.shared().pasteboardTextTranslate()
                }) {
                    HStack {
                        ZStack {
                            Color.accentColor
                            Image(systemName: "highlighter").foregroundColor(.white)
                        }
                        .cornerRadius(13)
                        .frame(width: 26, height: 26)
                        VStack(alignment: .leading) {
                            Text("Translate pasteboard")
                                .font(.headline)
                                .fontWeight(.regular)
                                .foregroundColor(Color.primary)
                            Text("⎇ D")
                                .font(.subheadline)
                                .foregroundColor(Color.secondary)
                        }
                        Spacer()
                    }
                }
                .buttonStyle(.plain)
            }
            .padding()
            .background(Color.bgMenuItem)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 10)
            Button(action: {
                NotificationCenter.default.post(name: Notification.Name(kNotificationCloseStatusWindow), object: nil)
                EZWindowManager.shared().screenshotOCR()
            }) {
                HStack {
                    ZStack {
                        Color.accentColor
                        Image(systemName: "dot.viewfinder").foregroundColor(.white)
                    }
                    .cornerRadius(13)
                    .frame(width: 26, height: 26)
                    VStack(alignment: .leading) {
                        Text("Silent Screenshot OCR")
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundColor(Color.primary)
                        Text("⎇ ⇧ S")
                            .font(.subheadline)
                            .foregroundColor(Color.secondary)
                    }
                    Spacer()
                }
                .padding()
                .background(Color.bgMenuItem)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 10)
            }
            .buttonStyle(.plain)
            Spacer().frame(height: 10)
            HStack(spacing: 10) {
                Button(action: {
                    NSApp.activate(ignoringOtherApps: true)
                    NotificationCenter.default.post(name: Notification.Name(kNotificationCloseStatusWindow), object: nil)
                    NotificationCenter.default.post(name: Notification.Name(kNotificationOpenSettingWindow), object: nil)
                }) {
                    VStack {
                        Spacer()
                        Image(systemName: "gear")
                            .foregroundColor(Color.secondary)
                            .frame(width: 24, height: 24)
                        Text("Setting")
                            .font(.subheadline)
                            .foregroundColor(Color.secondary)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.bgMenuItem)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 10)
                }
                .buttonStyle(.plain)
                Button(action: {
                    NotificationCenter.default.post(name: Notification.Name(kNotificationCloseStatusWindow), object: nil)
                    EZWindowManager.shared().inputTranslate(true)
                }) {
                    VStack {
                        Spacer()
                        Image(systemName: "dock.rectangle")
                            .foregroundColor(Color.secondary)
                            .frame(width: 24, height: 24)
                        Text("Show Window")
                            .font(.subheadline)
                            .foregroundColor(Color.secondary)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.bgMenuItem)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 10)
                }
                .buttonStyle(.plain)
                Button(action: {
                    NSApplication.shared.terminate(nil)
                }) {
                    VStack {
                        Spacer()
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(Color.secondary)
                            .frame(width: 24, height: 24)
                        Text("Quit")
                            .font(.subheadline)
                            .foregroundColor(Color.secondary)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.bgMenuItem)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 10)
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
        .background(Color.bgMenu)
        .cornerRadius(10)
        // .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0, y: 10)
    }
}
