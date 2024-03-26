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
                        Text("⎇ A")
                            .font(.subheadline)
                            .foregroundColor(Color.secondary)
                    }
                    Spacer()
                }
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
                        Text("⎇ S")
                            .font(.subheadline)
                            .foregroundColor(Color.secondary)
                    }
                    Spacer()
                }
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
                        Text("⎇ D")
                            .font(.subheadline)
                            .foregroundColor(Color.secondary)
                    }
                    Spacer()
                }
            }
            .padding()
            .background(Color.bgMenuItem)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 10)
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
            HStack(spacing: 10) {
                VStack {
                    Spacer()
                    Image(systemName: "gear")
                    Text("Setting")
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.bgMenuItem)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 10)
                VStack {
                    Spacer()
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                    Text("Quit")
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.bgMenuItem)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 10)
            }
        }
        .padding()
        .background(Color.bgMenu)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0, y: 10)
    }
}
