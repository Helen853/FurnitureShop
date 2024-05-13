//
//  Gradient.swift
//  FurnitureShop


import SwiftUI

struct GradientView: View {
    
    private enum Constants {
        static let startColor = "startGraund"
        static let endColor = "endGround"
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(Constants.startColor), Color(Constants.endColor)],
                startPoint: .leading,
                endPoint: .trailing
            ).ignoresSafeArea(.all)
        }
    }
}
