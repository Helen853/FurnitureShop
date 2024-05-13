//
//  Settings.swift
//  FurnitureShop

import Foundation

/// Данные для ячейки с разделами
struct Chapter: Identifiable {
    /// Ид
    var id = UUID()
    /// Картинка
    let image: String
    /// Наименование
    let title: String
}

/// Данные для ячейки с разделами и уведомлениями
struct ChapterBadge: Identifiable {
    /// Ид
    var id = UUID()
    /// Картинки
    let image: String
    /// Наименование
    let title: String
    /// Уведомления
    let nitifications: String
}
