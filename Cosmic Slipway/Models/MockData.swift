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
            Ship(id: 1, name: "Raven Striker", shipImage: "", fitting: Fitting(highSlots: 7, midSlots: 4, lowSlots: 6, combatRigs: 3, engineeringRigs: 3)),
            Ship(id: 1, name: "Tempest Striker", shipImage: "", fitting: Fitting(highSlots: 7, midSlots: 4, lowSlots: 6, combatRigs: 3, engineeringRigs: 3)),
            Ship(id: 1, name: "Apocalypse Striker", shipImage: "", fitting: Fitting(highSlots: 7, midSlots: 4, lowSlots: 6, combatRigs: 3, engineeringRigs: 3)),
            Ship(id: 1, name: "Megathron Striker", shipImage: "megathronStriker", fitting: Fitting(highSlots: 7, midSlots: 4, lowSlots: 6, combatRigs: 3, engineeringRigs: 3)),
        ])
    ]),
    ShipType(id: 7, name: "Capital Ships", subtypes: []),
]

let highSlotsMockData: [HighSlotsMainWeaponType] = [
    HighSlotsMainWeaponType(
        id: 1,
        name: "Lasers",
        subtype: [
            WeaponSubtype(
                id: 1,
                name: "",
                weaponModuleName: [
                    Weapon(id: 1, name: "")
                ])
        ]),
    HighSlotsMainWeaponType(
        id: 2,
        name: "Railguns",
        subtype: [
            WeaponSubtype(
                id: 1,
                name: "Small Rifled Railguns",
                weaponModuleName: [
                    Weapon(id: 1, name: "")
                ]),
            WeaponSubtype(
                id: 2,
                name: "Medium Rifled Railguns",
                weaponModuleName: [
                    Weapon(id: 2, name: "")
                ]),
            WeaponSubtype(
                id: 3,
                name: "Large Rifled Railguns",
                weaponModuleName: [
                    Weapon(id: 1, name: "Core C-Type Large Snubnosed Railguns", characteristics: WeaponCharacteristics(
                        dps: 83.24,
                        damageTypes: DamageTypes(em: 0, thermal: 245, kinetic: 419, explosive: 0),
                        metaLevel: 11,
                        powerGrid: 830,
                        activationCost: 15.1,
                        activationTime: 7.88,
                        optimalRange: 7.2,
                        fallOff: 10,
                        tracking: 7.09)
                    ),
                    Weapon(id: 2, name: "Core B-Type Large Snubnosed Railguns"),
                    Weapon(id: 3, name: "Core A-Type Large Snubnosed Railguns"),
                    Weapon(id: 4, name: "Core X-Type Large Snubnosed Railguns"),
                ]),
            WeaponSubtype(
                id: 4,
                name: "Capital Rifled Railguns",
                weaponModuleName: [
                    Weapon(id: 2, name: "")
                ])
        ]),
    HighSlotsMainWeaponType(id: 3, name: "Cannons", subtype: [
        WeaponSubtype(id: 1, name: "nil", weaponModuleName: [
            Weapon(id: 2, name: "")
        ])
    ]),
    HighSlotsMainWeaponType(id: 4, name: "Decomposers", subtype: [
        WeaponSubtype(id: 1, name: "nil", weaponModuleName: [
            Weapon(id: 2, name: "")
        ])
    ]),
    HighSlotsMainWeaponType(id: 5, name: "Missle Launchers", subtype: [
        WeaponSubtype(id: 1, name: "nil", weaponModuleName: [
            Weapon(id: 2, name: "")
        ])
    ]),
    HighSlotsMainWeaponType(id: 6, name: "Harvest Equipments", subtype: [
        WeaponSubtype(id: 1, name: "nil", weaponModuleName: [
            Weapon(id: 2, name: "")
        ])
    ]),
    HighSlotsMainWeaponType(id: 7, name: "Remote Shield Boosters", subtype: [
        WeaponSubtype(id: 1, name: "nil", weaponModuleName: [
            Weapon(id: 2, name: "")
        ])
    ]),
    HighSlotsMainWeaponType(id: 8, name: "Remote Armor Boosters", subtype: [
        WeaponSubtype(id: 1, name: "nil", weaponModuleName: [
            Weapon(id: 2, name: "")
        ])
    ]),
    HighSlotsMainWeaponType(id: 9, name: "Bombs", subtype: [
        WeaponSubtype(id: 1, name: "nil", weaponModuleName: [
            Weapon(id: 2, name: "")
        ])
    ])
]
