//
//  LanguageDetectOptimizeExtensions.swift
//  Easydict
//
//  Created by 戴藏龙 on 2024/1/13.
//  Copyright © 2024 izual. All rights reserved.
//

import Defaults
import Foundation

extension LanguageDetectOptimize: Defaults.Serializable {}

extension LanguageDetectOptimize: CaseIterable {
    public static let allCases: [LanguageDetectOptimize] = [.none, .baidu, .google]
}

extension LanguageDetectOptimize {
    var localizedStringResource: String {
        switch self {
        case .none:
            "Only use System language detection"
        case .google:
            "Use Google language detection for optimization"
        case .baidu:
            "Use Baidu language detection for optimization"
        @unknown default:
            "unknown_option"
        }
    }
}
