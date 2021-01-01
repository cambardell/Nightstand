//
//  Cosmetics.swift
//  Footnote2
//
//  Created by Cameron Bardell on 2019-12-10.
//  Copyright © 2019 Cameron Bardell. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: Int, alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(
            .sRGB,
            red: components.R,
            green: components.G,
            blue: components.B,
            opacity: alpha
        )
    }

    // Palette 1

    static let footnoteOrange = Color(NSColor(red: 0.97, green: 0.62, blue: 0.00, alpha: 1.00))
    static let footnoteRed = Color(NSColor(red: 0.61, green: 0.12, blue: 0.10, alpha: 1.00))
    static let footnoteLightRed = Color(NSColor(red: 0.66, green: 0.13, blue: 0.10, alpha: 1.00))

}


