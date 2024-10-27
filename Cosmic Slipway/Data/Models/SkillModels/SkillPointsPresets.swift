import Foundation

protocol SkillGroupExperience {
    func experienceForLevel(_ tech: SkillTech, _ level: CurrentSkillLevel) -> Int
}

enum SkillPresetTier: SkillGroupExperience {
    case tier1
    
    var experienceByTechAndLevel: [SkillTech: [CurrentSkillLevel: Int]] {
        switch self {
        case .tier1:
            return [
                .basic: [
                    .one: 55,
                    .two: 257,
                    .three: 1448,
                    .four: 8197,
                    .five: 46363
                ],
                .advanced: [
                    .one: 375,
                    .two: 1748,
                    .three: 9877,
                    .four: 55883,
                    .five: 316117
                ],
                .expert: [
                    .one: 1500,
                    .two: 6990,
                    .three: 39510,
                    .four: 223530,
                    .five: 1264470
                ]
            ]
        }
    }
    
    // Реализация метода для получения опыта по техлвл и уровню
    func experienceForLevel(_ tech: SkillTech, _ level: CurrentSkillLevel) -> Int {
        return experienceByTechAndLevel[tech]?[level] ?? 0
    }
}
