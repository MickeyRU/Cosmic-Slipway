import Foundation

enum SkillLevel: Int {
    case basic = 1
    case advanced = 2
    case expert = 3
}

struct SkillDependency {
    let requiredLevel: SkillLevel
    let minimumRequiredPoints: Int
}

struct SkillGroup: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let learnedPercent: Float
    let learnedSP: Int
    let skillsCategories: [SkillsCategory]
}

struct SkillsCategory: Identifiable {
    var id = UUID()
    let title: String
    let imageName: String
    let skills: [Skill]
}

struct Skill: Identifiable {
    var id = UUID()
    let title: String
    let imageName: String
    let skillLevel: SkillLevel
    //    let dependencies: [SkillDependency]
    //    let levelCharacteristics: [SkillLevel: [String: Any]] // Уровень и характеристики, которые он дает
}


let testSkills = [
    SkillGroup(
        title: "Cruising Technology",
        imageName: "cruisingTechnology",
        learnedPercent: 25.3,
        learnedSP: 15043,
        skillsCategories: [
            SkillsCategory(
                title: "Spaceship Command",
                imageName: "cruisingTechnology",
                skills: [
                    Skill(title: "Frigate Command", imageName: "cruisingTechnology", skillLevel: .basic),
                    Skill(title: "Advanced Frigate Command", imageName: "cruisingTechnology", skillLevel: .advanced),
                    Skill(title: "Expert Frigate Command", imageName: "cruisingTechnology", skillLevel: .expert),
                    Skill(title: "Cruiser Command", imageName: "cruisingTechnology", skillLevel: .basic),
                    Skill(title: "Advanced Cruiser Command", imageName: "cruisingTechnology", skillLevel: .advanced),
                    Skill(title: "Expert Cruiser Command", imageName: "cruisingTechnology", skillLevel: .expert),
                    Skill(title: "Battlecruiser Command", imageName: "cruisingTechnology", skillLevel: .basic),
                    Skill(title: "Advanced Battlecruiser Command", imageName: "cruisingTechnology", skillLevel: .advanced),
                    Skill(title: "Expert Battlecruiser Command", imageName: "cruisingTechnology", skillLevel: .expert),
                    Skill(title: "Battleship Command", imageName: "cruisingTechnology", skillLevel: .basic),
                    Skill(title: "Advanced Battleship Command", imageName: "cruisingTechnology", skillLevel: .advanced),
                    Skill(title: "Expert Battleship Command", imageName: "cruisingTechnology", skillLevel: .expert)
                ]
            ),
            SkillsCategory(
                title: "Capital Spaceship Command",
                imageName: "cruisingTechnology",
                skills: [
                    Skill(title: "Frigate Command", imageName: "cruisingTechnology", skillLevel: .basic),
                    Skill(title: "Advanced Frigate Command", imageName: "cruisingTechnology", skillLevel: .advanced),
                    Skill(title: "Expert Frigate Command", imageName: "cruisingTechnology", skillLevel: .expert)
                ]
            ),
            SkillsCategory(
                title: "Navigation",
                imageName: "cruisingTechnology",
                skills: [
                    Skill(title: "Frigate Command", imageName: "cruisingTechnology", skillLevel: .basic),
                    Skill(title: "Advanced Frigate Command", imageName: "cruisingTechnology", skillLevel: .advanced),
                    Skill(title: "Expert Frigate Command", imageName: "cruisingTechnology", skillLevel: .expert)
                ]
            )
        ]
    ),
    SkillGroup(
        title: "Maintenance Technology",
        imageName: "maintenanceTechnology",
        learnedPercent: 16.2,
        learnedSP: 3243,
        skillsCategories: [
            SkillsCategory(
                title: "Spaceship Command",
                imageName: "spaceshipCommand",
                skills: [
                    Skill(title: "Frigate Command", imageName: "frigateCommand", skillLevel: .basic),
                    Skill(title: "Advanced Frigate Command", imageName: "advancedFrigateCommand", skillLevel: .advanced),
                    Skill(title: "Expert Frigate Command", imageName: "expertFrigateCommand", skillLevel: .expert)
                ]
            )
        ]
    ),
    SkillGroup(
        title: "Electronics",
        imageName: "electronics",
        learnedPercent: 15.0,
        learnedSP: 232553,
        skillsCategories: [
            SkillsCategory(
                title: "Spaceship Command",
                imageName: "spaceshipCommand",
                skills: [
                    Skill(title: "Frigate Command", imageName: "frigateCommand", skillLevel: .basic),
                    Skill(title: "Advanced Frigate Command", imageName: "advancedFrigateCommand", skillLevel: .advanced),
                    Skill(title: "Expert Frigate Command", imageName: "expertFrigateCommand", skillLevel: .expert)
                ]
            )
        ]
    ),
    SkillGroup(
        title: "Weapon Technology",
        imageName: "weaponTechnology",
        learnedPercent: 11.3,
        learnedSP: 434434,
        skillsCategories: [
            SkillsCategory(
                title: "Spaceship Command",
                imageName: "spaceshipCommand",
                skills: [
                    Skill(title: "Frigate Command", imageName: "frigateCommand", skillLevel: .basic),
                    Skill(title: "Advanced Frigate Command", imageName: "advancedFrigateCommand", skillLevel: .advanced),
                    Skill(title: "Expert Frigate Command", imageName: "expertFrigateCommand", skillLevel: .expert)
                ]
            )
        ]
    ),
    SkillGroup(
        title: "Industrial Technology",
        imageName: "industrialTechnology",
        learnedPercent: 0.0,
        learnedSP: 33332,
        skillsCategories: [
            SkillsCategory(
                title: "Spaceship Command",
                imageName: "spaceshipCommand",
                skills: [
                    Skill(title: "Frigate Command", imageName: "frigateCommand", skillLevel: .basic),
                    Skill(title: "Advanced Frigate Command", imageName: "advancedFrigateCommand", skillLevel: .advanced),
                    Skill(title: "Expert Frigate Command", imageName: "expertFrigateCommand", skillLevel: .expert)
                ]
            )
        ]
    ),
    SkillGroup(
        title: "Social Science",
        imageName: "socialScience",
        learnedPercent: 18.57,
        learnedSP: 112,
        skillsCategories: [
            SkillsCategory(
                title: "Spaceship Command",
                imageName: "spaceshipCommand",
                skills: [
                    Skill(title: "Frigate Command", imageName: "frigateCommand", skillLevel: .basic),
                    Skill(title: "Advanced Frigate Command", imageName: "advancedFrigateCommand", skillLevel: .advanced),
                    Skill(title: "Expert Frigate Command", imageName: "expertFrigateCommand", skillLevel: .expert)
                ]
            )
        ]
    ),
    SkillGroup(
        title: "Applied Science",
        imageName: "appliedScience",
        learnedPercent: 0.0,
        learnedSP: 2332,
        skillsCategories: [
            SkillsCategory(
                title: "Spaceship Command",
                imageName: "spaceshipCommand",
                skills: [
                    Skill(title: "Frigate Command", imageName: "frigateCommand", skillLevel: .basic),
                    Skill(title: "Advanced Frigate Command", imageName: "advancedFrigateCommand", skillLevel: .advanced),
                    Skill(title: "Expert Frigate Command", imageName: "expertFrigateCommand", skillLevel: .expert)
                ]
            )
        ]
    ),
    SkillGroup(
        title: "Natural Science",
        imageName: "naturalScience",
        learnedPercent: 45.3,
        learnedSP: 32323,
        skillsCategories: [
            SkillsCategory(
                title: "Spaceship Command",
                imageName: "spaceshipCommand",
                skills: [
                    Skill(title: "Frigate Command", imageName: "frigateCommand", skillLevel: .basic),
                    Skill(title: "Advanced Frigate Command", imageName: "advancedFrigateCommand", skillLevel: .advanced),
                    Skill(title: "Expert Frigate Command", imageName: "expertFrigateCommand", skillLevel: .expert)
                ]
            )
        ]
    )
]


//
//let basicSkill = Skill(
//    title: "Frigate Command",
//    skillLevel: .basic,
//    dependencies: [],
//    levelCharacteristics: [
//        .basic: ["speed": 10],
//        .advanced: ["speed": 20, "accuracy": 15],
//        .expert: ["speed": 30, "accuracy": 25]
//    ]
//)
//
//let advancedSkill = Skill(
//    title: "Advanced Navigation",
//    skillLevel: .advanced,
//    dependencies: [SkillDependency(requiredLevel: .basic, minimumRequiredPoints: 4)],
//    levelCharacteristics: [
//        .basic: ["speed": 15],
//        .advanced: ["speed": 25, "accuracy": 20],
//        .expert: ["speed": 35, "accuracy": 30]
//    ]
//)
//
//let expertSkill = Skill(
//    title: "Expert Navigation",
//    skillLevel: .expert,
//    dependencies: [SkillDependency(requiredLevel: .advanced, minimumRequiredPoints: 5)],
//    levelCharacteristics: [
//        .basic: ["speed": 20],
//        .advanced: ["speed": 30, "accuracy": 25],
//        .expert: ["speed": 40, "accuracy": 35]
//    ]
//)
//
////func canUpgradeSkill(currentSkillLevel: SkillLevel, skill: Skill, pointsInPreviousLevel: Int) -> Bool {
////    if let dependency = skill.dependencies.first(where: { $0.requiredLevel == currentSkillLevel }) {
////        return pointsInPreviousLevel >= dependency.minimumRequiredPoints
////    }
////    return true
////}
