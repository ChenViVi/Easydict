//
//  AdvancedTab.swift
//  Easydict
//
//  Created by tisfeng on 2024/1/23.
//  Copyright © 2024 izual. All rights reserved.
//

import Defaults
import SwiftUI

struct AdvancedTab: View {
    var body: some View {
        Form {
            Section {
                Picker("setting.general.advance.default_tts_service", selection: $defaultTTSServiceType) {
                    ForEach(TTSServiceType.allCases, id: \.rawValue) { option in
                        Text(option.localizedStringResource)
                            .tag(option)
                    }
                }
                Toggle("setting.general.advance.enable_beta_feature", isOn: $enableBetaFeature)
            } header: {
                Text("setting.general.advance.header")
            }
        }
        // .formStyle(.grouped)
    }

    @Default(.defaultTTSServiceType) private var defaultTTSServiceType
    @Default(.enableBetaFeature) private var enableBetaFeature
}

#Preview {
    AdvancedTab()
}
