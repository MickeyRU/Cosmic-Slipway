//
//  Modules.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 10.04.2023.
//

import UIKit

struct HighSlotsMainWeaponType {
    let id: Int
    let name: String
    let subtype: [WeaponSubtype]
}

struct WeaponSubtype {
    let id: Int
    let name: String
    let weaponModuleName: [Weapon]
}

struct Weapon {
    let id: Int
    let name: String
    var characteristics: WeaponCharacteristics?
}

struct WeaponCharacteristics {
    var dps: Double
    var damageTypes: DamageTypes
    let metaLevel: Int
    var powerGrid: Double
    var activationCost: Double
    var activationTime: Double
    var optimalRange: Double
    var fallOff: Double
    var tracking: Double
}

struct DamageTypes {
    var em: Int
    var thermal: Int
    var kinetic: Int
    var explosive: Int
}
