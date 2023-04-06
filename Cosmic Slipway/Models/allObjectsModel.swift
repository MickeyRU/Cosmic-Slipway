//
//  allObjectsModel.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 04.04.2023.
//

import UIKit

protocol IdentifiableWithName {
    var id: Int { get } // Уникальный идентификатор
    var name: String { get } // Название
}

// Структура для хранения данных типа корабля
struct ShipType: Codable, IdentifiableWithName {
    let id: Int
    let name: String
    let subtypes: [ShipSubtype] // Подтипы корабля
}

// Структура для хранения данных подтипа корабля
struct ShipSubtype: Codable, IdentifiableWithName {
    let id: Int
    let name: String
    let ships: [Ship] // Корабли подтипа
}

// Структура для хранения данных конкретного корабля
struct Ship: Codable, IdentifiableWithName {
    let id: Int
    let name: String
    let shipImage: String
    var characteristics: ShipCharacteristics // Характеристики корабля
    var fitting: [HighSlotModule]? // Модули корабля (может отсутствовать)
    var core: ShipCore? // Ядро корабля (может отсутствовать)
}
 
// Структура для хранения характеристик ядра
struct ShipCore: Codable {
    
}

// Структура для хранения характеристик корабля
struct ShipCharacteristics: Codable {
    
}

// Структура для хранения данных модуля корабля
struct HighSlotModule: Codable {
    let id: Int?
    let name: String?
}
