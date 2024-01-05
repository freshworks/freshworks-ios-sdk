//
//  BlurredView.swift
//  SouthWest
//
//  Created by Pramit Tewari on 06/11/23.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: style)
        return UIVisualEffectView(effect: blurEffect)
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

struct BlurredView: View {
    var body: some View {
        ZStack {
            Color.white.opacity(0.1)
            BlurView(style: .systemUltraThinMaterialDark)
        }
    }
}
