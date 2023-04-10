//
//  allObjectsModel.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 04.04.2023.
//

import UIKit

// Структура для хранения данных типа корабля
struct ShipType: Codable {
    let id: Int
    let name: String
    let subtypes: [ShipSubtype] // Подтипы корабля
}

// Структура для хранения данных подтипа корабля
struct ShipSubtype: Codable {
    let id: Int
    let name: String
    let ships: [Ship] // Корабли подтипа
}
 
// Структура для хранения данных конкретного корабля
struct Ship: Codable {
    let id: Int
    let name: String
    let shipImage: String?
    var characteristics: ShipCharacteristics? // Характеристики корабля
    var fitting: Fitting // Модули корабля
    var core: ShipCore? // Ядро корабля (может отсутствовать)
}

// Структура для хранения характеристик ядра
struct ShipCore: Codable {
    
}

// Структура для хранения характеристик корабля
struct ShipCharacteristics: Codable {
    
}

// Структура для хранения оснащения корабля
struct Fitting: Codable {
    let highSlots: Int
    let midSlots: Int
    let lowSlots: Int
    let combatRigs: Int
    let engineeringRigs: Int
}
