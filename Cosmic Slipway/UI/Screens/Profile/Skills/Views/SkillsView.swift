import SwiftUI

struct SkillsView: View {
    let skillsSubGroups: [SkillsSubGroup]

    var body: some View {
        ZStack {
            ScreenBGImageView(image: .mainBG)
            
            List(skillsSubGroups) { subGroup in
                SkillsSubGroupView(subGroup: subGroup)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
            }
            .shadow(color: Color.pureBlack.opacity(0.2), radius: 6, x: 0, y: -4)
            .buttonStyle(.plain)
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .padding(.vertical, 1)
        }
    }
}

struct SkillsSubGroupView: View {
    let subGroup: SkillsSubGroup

    var body: some View {
        VStack {
            SkillCellView(skill: subGroup.basicSkill, subGroupId: subGroup.id)
            CustomDivider()
            SkillCellView(skill: subGroup.advancedSkill, subGroupId: subGroup.id)
            CustomDivider()
            SkillCellView(skill: subGroup.expertSkill, subGroupId: subGroup.id)
        }
        .padding()
        .background(Color.darkBG.opacity(Alpha.mediumTransparent.rawValue))
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .stroke(LinearGradient(
                    gradient: Gradient(colors: [
                        Color(UIColor.gradientFrom.withAlphaComponent(0.2)),
                        Color(UIColor.gradientMiddle.withAlphaComponent(0.4)),
                        Color(UIColor.gradientTo.withAlphaComponent(0.2))
                    ]),
                    startPoint: .init(x: 0.9, y: 0),
                    endPoint: .init(x: 0.1, y: 1)
                ), lineWidth: 1)
        )
    }
}

struct SkillCellView: View {
    @EnvironmentObject private var skillsDataManager: SkillsDataManager
    let skill: Skill
    let subGroupId: UUID
    
    var body: some View {
        HStack(spacing: 20) {
            SkillImageView(image: skill.imageName, size: .small)
            
            VStack(alignment: .leading, spacing: 16){
                Text(skill.title)
                    .font(AppFonts.figtreeExBold16SwiftUI)
                    .foregroundStyle(.active)
                HStack {
                    Text(String(format: NSLocalizedString("SP: %@",
                                                          tableName: "SkillsLocalization",
                                                          comment: ""),
                                skill.getSPforCurrentLVL().formattedWithSpaceSeparator()))
                        .font(AppFonts.figtreeRegular12SwiftUI)
                        .foregroundStyle(.iconText)
                    
                    Spacer()
                    
                    CustomStepper(
                        level: skill.currentLvl,
                        onIncrement: {
                            Task {
                                try await skillsDataManager.tryAsyncChangeSkillLevel(subGroupId: subGroupId,
                                                                                     skillTech: skill.skillTech,
                                                                                     increase: true)
                            }
                        },
                        onDecrement: {
                            Task {
                                try await skillsDataManager.tryAsyncChangeSkillLevel(subGroupId: subGroupId,
                                                                                     skillTech: skill.skillTech,
                                                                                     increase: false)
                            }
                        }
                    )
                }
            }
        }
        .padding(.vertical, 8)
    }
}

struct CustomDivider: View {
    var body: some View {
        Divider()
            .background(Color.iconText)
    }
}

#Preview {
    SkillsView(skillsSubGroups: testSkills[0].skillsGroups[0].skillsSubGroups)
        .environmentObject(SkillsDataManager())
}
