//
//  NoTapEffectButton.swift
//  SouthWest
//
//  Created by Pramit Tewari on 12/12/23.
//

import UIKit
import SwiftUI

struct NoTapEffectButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}
