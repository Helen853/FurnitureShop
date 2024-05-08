//
//  View+Extension.swift
//  FurnitureShop

import SwiftUI

/// Расширение для вью
extension View {
    /// Закругление определенных углов вью
    /// -Parameters:
    /// radius: Размер радиуса
    /// corners: угол закругления
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

/// Вью закругленными углами
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
