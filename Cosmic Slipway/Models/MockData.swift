//
//  MockData.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 05.04.2023.
//

import UIKit

let mockData: [ShipType] = [
    ShipType(id: 1, name: "Frigates", subtypes: []),
    ShipType(id: 2, name: "Destroyers", subtypes: []),
    ShipType(id: 3, name: "Cruisers", subtypes: []),
    ShipType(id: 4, name: "Battlecruisers", subtypes: []),
    ShipType(id: 5, name: "Industrial Ships", subtypes: []),
    ShipType(id: 6, name: "Battleships", subtypes: [
        ShipSubtype(id: 1, name: "Battleships", ships: []),
        ShipSubtype(id: 2, name: "Siege BattleShips", ships: [
            Ship(id: 1, name: "Raven Striker", shipImage: "", characteristics: ShipCharacteristics(), fitting: [ShipModule()], core: ShipCore()),
            Ship(id: 2, name: "Tempest Striker", shipImage: "", characteristics: ShipCharacteristics(), fitting: [ShipModule()], core: ShipCore()),
            Ship(id: 2, name: "Apocalypse Striker", shipImage: "", characteristics: ShipCharacteristics(), fitting: [ShipModule()], core: ShipCore()),
            Ship(id: 2, name: "Megathron Striker", shipImage: "megathronStriker", characteristics: ShipCharacteristics(), fitting: [ShipModule()], core: ShipCore()),
        ])
    ]),
    ShipType(id: 7, name: "Capital Ships", subtypes: []),
]






