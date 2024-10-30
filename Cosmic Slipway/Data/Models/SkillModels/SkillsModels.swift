import Foundation

protocol SkillsIdentifiable: Identifiable {
    var id: UUID { get }
    var title: String { get }
    var imageName: String { get }
}

enum SkillTech: String {
    case basic = "Basic"
    case advanced = "Advanced"
    case expert = "Expert"
}

enum CurrentSkillLevel: Int, Comparable {
    case zero, one, two, three, four, five
    
    static func < (lhs: CurrentSkillLevel, rhs: CurrentSkillLevel) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

enum SkillTierDependency {
    case tier1  // 4-5-0  (basic -> advanced (если basic минимум в 4), advanced -> expert (если advanced минимум в 5)
    
    func isSatisfiedForLvlUp(for currentTech: SkillTech, basedOn subgroup: SkillsSubGroup) -> Bool {
        switch self {
        case .tier1:
            switch currentTech {
            case .basic:
                return true
            case .advanced:
                return subgroup.basicSkill.currentLvl.rawValue >= 4
            case .expert:
                return subgroup.advancedSkill.currentLvl.rawValue == 5
            }
        }
    }
    
    func isSatisfiedForLvlDown(for currentTech: SkillTech, basedOn subgroup: SkillsSubGroup) -> Bool {
        switch self {
        case .tier1:
            switch currentTech {
            case .basic:
                return subgroup.advancedSkill.currentLvl.rawValue == 0
            case .advanced:
                return subgroup.expertSkill.currentLvl.rawValue == 0
            case .expert:
                return true
            }
        }
    }
}

struct SkillsCategory: SkillsIdentifiable {
    let id = UUID()
    var title: String
    var imageName: String
    var skillsGroups: [SkillsGroup]
    
    var learnedSP: Int {
        skillsGroups.reduce(0) { $0 + $1.totalSP }
    }
    
    var learnedPercent: Float {
        let totalSP = skillsGroups.reduce(0) { $0 + $1.maxSP }
        let percent = totalSP > 0 ? (Float(learnedSP) / Float(totalSP)) * 100 : 0
        return (percent * 100).rounded() / 100
    }
}

struct SkillsGroup: SkillsIdentifiable {
    let id = UUID()
    var title: String
    var imageName: String
    var skillsSubGroups: [SkillsSubGroup]
    
    var totalSP: Int {
        skillsSubGroups.reduce(0) { $0 + $1.currentSP }
    }
    
    var maxSP: Int {
        skillsSubGroups.reduce(0) { $0 + $1.maxSP }
    }
}

struct SkillsSubGroup: Identifiable {
    let id = UUID()
    var basicSkill: Skill
    var advancedSkill: Skill
    var expertSkill: Skill
    
    let dependency: SkillTierDependency
    
    var currentSP: Int {
        basicSkill.getSPforCurrentLVL() + advancedSkill.getSPforCurrentLVL() + expertSkill.getSPforCurrentLVL()
    }
    
    var maxSP: Int {
        basicSkill.maxSP + advancedSkill.maxSP + expertSkill.maxSP
    }
    
    func canLevelUp(from currentTech: SkillTech) -> Bool {
        return dependency.isSatisfiedForLvlUp(for: currentTech, basedOn: self)
    }
    
    func canLevelDown(from currentTech: SkillTech) -> Bool {
        return dependency.isSatisfiedForLvlDown(for: currentTech, basedOn: self)
    }
    
    mutating func changeSkillLevel(for tech: SkillTech, increase: Bool) {
        switch tech {
        case .basic:
            if increase {
                basicSkill.lvlUp()
            } else {
                basicSkill.lvlDown()
            }
        case .advanced:
            if increase {
                advancedSkill.lvlUp()
            } else {
                advancedSkill.lvlDown()
            }
        case .expert:
            if increase {
                expertSkill.lvlUp()
            } else {
                expertSkill.lvlDown()
            }
        }
    }
}

struct Skill: Identifiable {
    let id: UUID = UUID()
    var title: String
    var imageName: String
    let skillTech: SkillTech
    let experiencePreset: SkillPresetTier
    var currentLvl: CurrentSkillLevel = .zero
    
    var maxSP: Int {
        (0...5).reduce(0) { total, level in
            if let skillLevel = CurrentSkillLevel(rawValue: level) {
                return total + experiencePreset.experienceForLevel(skillTech, skillLevel)
            }
            return total
        }
    }
    
    mutating func lvlUp() {
        let nextLevel = currentLvl.rawValue + 1
        guard nextLevel <= 5, let newLevel = CurrentSkillLevel(rawValue: nextLevel) else { return }
        currentLvl = newLevel
    }
    
    mutating func lvlDown() {
        let previousLevel = currentLvl.rawValue - 1
        guard previousLevel >= 0, let newLevel = CurrentSkillLevel(rawValue: previousLevel) else { return }
        currentLvl = newLevel
    }
    
    func getSPforCurrentLVL() ->  Int {
        var totalSp: Int = 0
        
        for level in CurrentSkillLevel.zero.rawValue...currentLvl.rawValue {
            if let skillLevel = CurrentSkillLevel(rawValue: level) {
                totalSp += experiencePreset.experienceForLevel(skillTech, skillLevel)
            }
        }
        
        return totalSp
    }
}
