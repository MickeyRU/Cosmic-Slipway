//
//  allObjectsModel.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 04.04.2023.
//

import UIKit

// Структура для хранения данных типа корабля
struct ShipType {
    let id: Int
    let name: String
    let subtypes: [ShipSubtype] // Подтипы корабля
}

// Структура для хранения данных подтипа корабля
struct ShipSubtype {
    let id: Int
    let name: String
    let ships: [Ship] // Корабли подтипа
}
 
// Структура для хранения данных конкретного корабля
struct Ship {
    let id: Int
    let name: String
    let shipImage: String
    var fitting: Fitting // Модули корабля
}

// Структура для хранения оснащения корабля
struct Fitting {
    let highSlots: Int
    let midSlots: Int
    let lowSlots: Int
    let combatRigs: Int
    let engineeringRigs: Int
}
