//
//  EggTimerData.swift
//  Egg Timer
//
//  Created by KirtiS on 2/2/25.
//

import Foundation

struct CardDataModel: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let yolkTexture: String
    let cookingTime: String
}

struct CardData {
    static let cardData: [CardDataModel] = [
        CardDataModel(title: "Soft Boiled", yolkTexture: "Runny Yolk", cookingTime: "6 Minutes"),
        CardDataModel(title: "Medium Boiled", yolkTexture: "Gel-Like Yolk", cookingTime: "9 Minutes"),
        CardDataModel(title: "Firm Boiled", yolkTexture: "Firm Yolk", cookingTime: "12 Minutes"),
        CardDataModel(title: "Hard Boiled", yolkTexture: "Hard Yolk", cookingTime: "15 Minutes")
    ]
}

