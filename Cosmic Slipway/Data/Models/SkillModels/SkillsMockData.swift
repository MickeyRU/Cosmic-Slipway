let testSkills = [
    SkillsCategory(
        title: "Cruising Technology",
        imageName: "cruisingTechnology",
        learnedPercent: 25.3,
        learnedSP: 15043,
        skillsGroups: [
            SkillsGroup(
                title: "Spaceship Command",
                imageName: "cruisingTechnology",
                skillsSubGroups: [
                    SkillsSubGroup(
                        basicSkill: Skill(title: "Frigate Command", imageName: "cruisingTechnology", skillTech: .basic, experiencePreset: .tier1),
                        advancedSkill: Skill(title: "Advanced Frigate Command", imageName: "cruisingTechnology", skillTech: .advanced, experiencePreset: .tier1),
                        expertSkill: Skill(title: "Expert Frigate Command", imageName: "cruisingTechnology", skillTech: .expert, experiencePreset: .tier1),
                        dependency: .tier1
                    ),
                    SkillsSubGroup(
                        basicSkill: Skill(title: "Cruiser Command", imageName: "cruisingTechnology", skillTech: .basic, experiencePreset: .tier1),
                        advancedSkill: Skill(title: "Advanced Cruiser Command", imageName: "cruisingTechnology", skillTech: .advanced, experiencePreset: .tier1),
                        expertSkill: Skill(title: "Expert Cruiser Command", imageName: "cruisingTechnology", skillTech: .expert, experiencePreset: .tier1),
                        dependency: .tier1
                    ),
                    SkillsSubGroup(
                        basicSkill: Skill(title: "Battlecruiser Command", imageName: "cruisingTechnology", skillTech: .basic, experiencePreset: .tier1),
                        advancedSkill: Skill(title: "Advanced Battlecruiser Command", imageName: "cruisingTechnology", skillTech: .advanced, experiencePreset: .tier1),
                        expertSkill: Skill(title: "Expert Battlecruiser Command", imageName: "cruisingTechnology", skillTech: .expert, experiencePreset: .tier1),
                        dependency: .tier1
                    )
                ]
            ),
            
        ]
    )
]
    
