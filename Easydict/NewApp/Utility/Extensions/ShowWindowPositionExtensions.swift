//
//  ShowWindowPositionExtensions.swift
//  Easydict
//
//  Created by 戴藏龙 on 2024/1/13.
//  Copyright © 2024 izual. All rights reserved.
//

import Defaults
import Foundation

extension EZShowWindowPosition: Defaults.Serializable {}

extension EZShowWindowPosition: CaseIterable {
    public static let allCases: [EZShowWindowPosition] = [.right, .mouse, .former, .center]
}

public extension EZShowWindowPosition {
    var localizedStringResource: String {
        switch self {
        case .right:
            "Right side of screen"
        case .mouse:
            "Mouse position"
        case .former:
            "Last position"
        case .center:
            "Center of screen"
        @unknown default:
            "unknown_option"
        }
    }
}
