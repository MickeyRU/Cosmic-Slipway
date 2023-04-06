//
//  MockData.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 05.04.2023.
//

import UIKit

let shipsMockData: [ShipType] = [
    ShipType(id: 1, name: "Frigates", subtypes: []),
    ShipType(id: 2, name: "Destroyers", subtypes: []),
    ShipType(id: 3, name: "Cruisers", subtypes: []),
    ShipType(id: 4, name: "Battlecruisers", subtypes: []),
    ShipType(id: 5, name: "Industrial Ships", subtypes: []),
    ShipType(id: 6, name: "Battleships", subtypes: [
        ShipSubtype(id: 1, name: "Battleships", ships: []),
        ShipSubtype(id: 2, name: "Siege BattleShips", ships: [
            Ship(id: 1, name: "Raven Striker", shipImage: "", characteristics: ShipCharacteristics(), fitting: [HighSlotModule(id: nil, name: nil)], core: ShipCore()),
            Ship(id: 2, name: "Tempest Striker", shipImage: "", characteristics: ShipCharacteristics(), fitting: [HighSlotModule(id: nil, name: nil)], core: ShipCore()),
            Ship(id: 2, name: "Apocalypse Striker", shipImage: "", characteristics: ShipCharacteristics(), fitting: [HighSlotModule(id: nil, name: nil)], core: ShipCore()),
            Ship(id: 2, name: "Megathron Striker", shipImage: "megathronStriker", characteristics: ShipCharacteristics(), fitting: [HighSlotModule(id: nil, name: nil)], core: ShipCore()),
        ])
    ]),
    ShipType(id: 7, name: "Capital Ships", subtypes: []),
]

let highSlotsMockData: [HighSlotModule] = [
    HighSlotModule(id: 1, name: "Lasers"),
    HighSlotModule(id: 2, name: "Rialguns"),
    HighSlotModule(id: 3, name: "Cannons"),
    HighSlotModule(id: 4, name: "Decomposers"),
    HighSlotModule(id: 5, name: "Missle Launchers"),
    HighSlotModule(id: 6, name: "Harvest Equipments"),
    HighSlotModule(id: 7, name: "Remote Shield Boosters"),
    HighSlotModule(id: 8, name: "Remote Armor Boosters"),
    HighSlotModule(id: 9, name: "Bombs"),
]
