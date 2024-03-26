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
                Button(action: {}) {
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
                                .foregroundColor(Color.black)
                            Text("⎇ A")
                                .font(.subheadline)
                                .foregroundColor(Color.secondary)
                        }
                        Spacer()
                    }
                }
                .buttonStyle(.borderless)
                Button(action: {}) {
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
                                .foregroundColor(Color.black)
                            Text("⎇ S")
                                .font(.subheadline)
                                .foregroundColor(Color.secondary)
                        }
                        Spacer()
                    }
                }
                .buttonStyle(.borderless)
                Button(action: {}) {
                    HStack {
                        ZStack {
                            Color.accentColor
                            Image(systemName: "highlighter").foregroundColor(.white)
                        }
                        .cornerRadius(13)
                        .frame(width: 26, height: 26)
                        VStack(alignment: .leading) {
                            Text("Select Translate")
                                .font(.headline)
                                .fontWeight(.regular)
                                .foregroundColor(Color.black)
                            Text("⎇ D")
                                .font(.subheadline)
                                .foregroundColor(Color.secondary)
                        }
                        Spacer()
                    }
                }
                .buttonStyle(.borderless)
            }
            .padding()
            .background(Color.bgMenuItem)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 10)
            Button(action: {}) {
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
                            .foregroundColor(Color.black)
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
            .buttonStyle(.borderless)
            HStack(spacing: 10) {
                Button(action: {}) {
                    VStack {
                        Spacer()
                        Image(systemName: "gear")
                            .foregroundColor(Color.black)
                        Text("Setting")
                            .foregroundColor(Color.black)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.bgMenuItem)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 10)
                }
                .buttonStyle(.borderless)
                Button(action: {}) {
                    VStack {
                        Spacer()
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(Color.black)
                        Text("Quit")
                            .foregroundColor(Color.black)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.bgMenuItem)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 10)
                }
                .buttonStyle(.borderless)
            }
        }
        .padding()
        .background(Color.bgMenu)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0, y: 10)
    }
}
