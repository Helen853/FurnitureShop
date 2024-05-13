//
//  StorageFurniture.swift
//  FurnitureShop

import Foundation

/// Хранилище данных о товаре
struct StorageFurniture {
    /// Массив с товарами
    var furniture: [Furniture]
    
    init() {
        self.furniture = [
            .init(
                image: "sofa2",
                name: "Sofa",
                newPrice: 999,
                oldPrice: 2000,
                count: 0,
                article: "283564",
                description: " A sofa in a modern style is furniture without lush ornate decor. It has a simple or even futuristic appearance and sleek design"),
            .init(
                image: "armchair",
                name: "Armchair",
                newPrice: 99,
                oldPrice: 200,
                count: 0,
                article: "238490",
                description: " An armchair is a comfortable, cushioned chair with a support on each side, where you can rest your arms while you sit. Some armchairs are big enough that you can curl up and read a book in them."),
            .init(
                image: "bed",
                name: "Bed",
                newPrice: 1000,
                oldPrice: 2000,
                count: 0,
                article: "478403",
                description: "A bed is an item of furniture that is used as a place to sleep, rest, and relax. Most modern beds consist of a soft, cushioned mattress on a bed frame. The mattress rests either on a solid base, often wood slats, or a sprung base"),
            .init(
                image: "table",
                name: "Table",
                newPrice: 600,
                oldPrice: 1200,
                count: 0,
                article: "348953",
                description: "A table is a piece of furniture with a flat top supported by one or more legs. People put things on a table, often for a short time, for example food and knives and forks, etc. at a meal, cups for drinks, a book, a map, writing paper when writing, and things for hobbies"),
            .init(
                image: "chair",
                name: "Сhair",
                newPrice: 99,
                oldPrice: 200,
                count: 0,
                article: "349800",
                description: "A chair is a type of seat, typically designed for one person and consisting of one or more legs, a flat or slightly angled seat and a back-rest"),
            .init(
                image: "wardrobe",
                name: " Wardrobe",
                newPrice: 899,
                oldPrice: 1100,
                count: 0,
                article: "987322",
                description: "A wardrobe, also called armoire or almirah, is a standing closet used for storing clothes. The earliest wardrobe was a chest, and it was not until some degree of luxury was attained in regal palaces and the castles of powerful nobles that separate accommodation was provided for the apparel of the great.")
        ]
    }
}
