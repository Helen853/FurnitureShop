//
//  AnyTransition+Extension.swift
//  FurnitureShop

import SwiftUI

extension AnyTransition {
   static var zoomAsymInOut: AnyTransition {
        .asymmetric(
            insertion: .scale(scale: 0.1, anchor: .topLeading).combined(with: .offset(y: 120)),
            removal: .scale(scale: 0.2).combined(with: .opacity)
        )
    }
}
