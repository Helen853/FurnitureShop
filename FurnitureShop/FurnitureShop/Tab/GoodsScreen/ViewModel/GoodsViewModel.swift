//
//  GoodsViewModel.swift
//  FurnitureShop

import Foundation

/// ViewModel для экрана c категориями
final class GoodsViewModel: ObservableObject {
    @Published var furniture = StorageFurniture()
    @Published var count = [0, 0, 0, 0, 0, 0]
    @Published var allPrice = 0
    
    /// Увеличение прайса на стоимость добавленного товара
    /// - Parameters:
    /// - price:стоимость товара
    /// - item: конкретная мебель
    func addPrice(price: Int, item: Furniture) {
        allPrice += price
        for i in 0..<furniture.furniture.count-1 {
            if furniture.furniture[i] == item {
                count[i] += 1
            }
        }
    }
    
    /// Уменьшение прайса на стоимость добавленного товара
    /// - Parameters:
    /// - price:стоимость товара
    /// - item: конкретная мебель
    func removePrice(price: Int, item: Furniture) {
        guard allPrice >= 1 else { return }
        allPrice -= price
        for i in 0..<furniture.furniture.count-1 {
            if furniture.furniture[i] == item {
                guard count[i] >= 1 else { return }
                count[i] -= 1
            }
        }
    }
}
