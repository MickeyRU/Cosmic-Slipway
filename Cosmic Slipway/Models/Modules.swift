//
//  Modules.swift
//  Cosmic Slipway
//
//  Created by Павел Афанасьев on 10.04.2023.
//

import UIKit

struct HighSlotsMainWeaponType: Codable, IdentifiableWithName {
    var id: Int
    var name: String
    let subtype: [WeaponSubtype]?
}

struct WeaponSubtype: Codable, IdentifiableWithName {
    var id: Int?
    var name: String?
    let weaponModuleName: [Weapon]?
}

struct Weapon: Codable, IdentifiableWithName {
    var id: Int?
    var name: String?
}
