//
//  FiltersViewModel.swift
//  FurnitureShop


import Foundation

/// ViewModel для экрана c фильтрами
final class FiltersViewModel: ObservableObject {
    @Published var currentPrice: Double = 500
    
    @Published var colors = ["bardo", "black", "blue", "brown", "darkGreen", "grape", "green", "ice", "ingigo", "iron", "lightGray", "magenta", "ocean", "orange", "pink", "purple", "red", "teal", "white", "yellow"]
    
    @Published var colorText = "Color"
    
    /// Установление актуального прайса
    func setCurrentPrice(sliderValue: Double) {
        currentPrice = sliderValue
    }
    
    /// Установка текста над цветом
    func setColor(index: Int) {
        colorText = "Color - \(colors[index])"
    }
}
