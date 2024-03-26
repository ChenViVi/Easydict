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
                        Image(systemName: "keyboard")
                    }
                    .cornerRadius(13)
                    .frame(width: 26, height: 26)
                    Text("Input Translate")
                }
                Text("Screenshot Translate")
                Text("Select Translate")
            }
        }
    }
}
