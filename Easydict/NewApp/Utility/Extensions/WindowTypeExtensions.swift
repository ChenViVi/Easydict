//
//  WindowTypeExtensions.swift
//  Easydict
//
//  Created by 戴藏龙 on 2024/1/13.
//  Copyright © 2024 izual. All rights reserved.
//

import Defaults
import Foundation

extension EZWindowType: Defaults.Serializable {}

public extension EZWindowType {
    static let availableOptions: [EZWindowType] = [.mini, .fixed]
}

public extension EZWindowType {
    var localizedStringResource: String {
        switch self {
        case .fixed:
            "Fixed float window"
        case .main:
            "Main window"
        case .mini:
            "Mini window"
        case .none:
            "none_window"
        @unknown default:
            "unknown_option"
        }
    }
}
