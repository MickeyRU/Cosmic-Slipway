import SwiftUI

struct SkillsCategoriesView: View {
    @EnvironmentObject private var skillsDataManager: SkillsDataManager
    
    var body: some View {
        ZStack {
            ScreenBGImageView(image: .mainBG)
            
            List(skillsDataManager.skillsCategories) { skill in
                SkillGroupsCell(skillGroup: skill)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
            }
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .padding(.vertical, 1)
        }
    }
}

struct SkillGroupsCell: View {
    @EnvironmentObject private var skillsDataManager: SkillsDataManager
    let skillGroup: SkillsCategory
    
    var body: some View {
        ZStack {
            GroupInfoView(skillsCategory: skillGroup)
            NavigationLink(destination: SkillGroupsView(skillCategories: skillGroup.skillsGroups).environmentObject(skillsDataManager)) {
                EmptyView()
            }
            .opacity(0)
        }
        .shadow(color: Color.pureBlack.opacity(0.2), radius: 6, x: 0, y: -4)
    }
}

struct GroupInfoView: View {
    let skillsCategory: SkillsCategory
    
    var body: some View {
        HStack(alignment: .center, spacing: 24) {
            SkillImageView(image: skillsCategory.imageName, size: .regular)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(skillsCategory.title)
                        .font(AppFonts.figtreeExBold16SwiftUI)
                        .foregroundStyle(.accent)
                }
                
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(String(format: NSLocalizedString("Learned: %.1f%%",
                                                              tableName: "SkillsLocalization",
                                                              comment: ""), skillsCategory.learnedPercent))
                        Text(String(format: NSLocalizedString("Total SP: %@",
                                                              tableName: "SkillsLocalization",
                                                              comment: ""), skillsCategory.learnedSP.formatted()))
                    }
                    .font(AppFonts.figtreeRegular12SwiftUI)
                    .foregroundStyle(.iconText)
                    
                    Spacer()
                    
                    EditButtonWithArrowView(text: NSLocalizedString("Edit",
                                                                    tableName: "SkillsLocalization",
                                                                    comment: ""))
                }
            }
            
        }
        .padding(24)
        .background(Color.darkBG.opacity(Alpha.mediumTransparent.rawValue))
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .stroke(LinearGradient(
                    gradient: Gradient(colors: [
                        Color(UIColor.active.withAlphaComponent(0.2)),
                        Color(UIColor.pureBlack.withAlphaComponent(0.3))
                    ]),
                    startPoint: .init(x: 0, y: 0),
                    endPoint: .init(x: 0.3, y: 0.2)
                ), lineWidth: 1)
        )
    }
}

#Preview {
    let skillsDataManager = SkillsDataManager()
    SkillsCategoriesView()
        .environmentObject(skillsDataManager)
}
