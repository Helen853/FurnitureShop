//
//  GoodsViewModel.swift
//  FurnitureShop

import SwiftUI

/// ViewModel для экрана c категориями
final class GoodsViewModel: ObservableObject {
    @Published var furniture = [
        Furniture(image: "sofa2", name: "Sofa", newPrice: 999, oldPrice: 2000, count: 0),
        Furniture(image: "armchair", name: "Armchair", newPrice: 99, oldPrice: 200, count: 0),
        Furniture(image: "bed", name: "Bed", newPrice: 1000, oldPrice: 2000, count: 0),
        Furniture(image: "table", name: "Table", newPrice: 600, oldPrice: 1200, count: 0),
        Furniture(image: "chair", name: "Сhair", newPrice: 99, oldPrice: 200, count: 0),
        Furniture(image: "wardrobe", name: " Wardrobe", newPrice: 899, oldPrice: 1100, count: 0)
    ]
    @Published var count = [0, 0, 0, 0, 0, 0]

    @Published var allPrice = 0
    
    func addPrice(price: Int, item: Furniture) {
        allPrice += price
        for i in 0..<furniture.count-1 {
            if furniture[i] == item {
                count[i] += 1
            }
        }
        
    }
    
    func removePrice(price: Int, item: Furniture) {
        allPrice -= price
        for i in 0..<furniture.count-1 {
            if furniture[i] == item {
                count[i] -= 1
            }
        }
    }
}
