//
//  Furniture.swift
//  FurnitureShop

import Foundation

/// Модель мебели
struct Furniture: Equatable {
    /// Картинка
    let image: String
    /// Наименование
    let name: String
    /// Новый цена
    let newPrice: Int
    /// Старая цена
    let oldPrice: Int
    /// Кол-во товара
    let count: Int
    /// Артикул
    let article: String
    /// Описание
    let description: String
}
