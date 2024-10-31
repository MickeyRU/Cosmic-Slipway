import SwiftUI

struct SkillGroupsView: View {
    let skillCategories: [SkillsGroup]
    
    var body: some View {
        ZStack {
            ScreenBGImageView(image: .mainBG)
            
            List(skillCategories) { skillCategory in
                CategoriesCellView(skillCategory: skillCategory)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
            }
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .padding(.vertical, 1)
        }
    }
}

struct CategoriesCellView: View {
    @EnvironmentObject private var skillsDataManager: SkillsDataManager

    let skillCategory: SkillsGroup
    
    var body: some View {
        ZStack {
            CategoryInfoView(skillCategory: skillCategory)
            NavigationLink(destination: SkillsView(skillsSubGroups: skillCategory.skillsSubGroups).environmentObject(skillsDataManager)) {
                EmptyView()
            }
            .opacity(0)
        }
        .shadow(color: Color.pureBlack.opacity(0.2), radius: 6, x: 0, y: -4)
    }
}

struct CategoryInfoView: View {
    let skillCategory: SkillsGroup

    var body: some View {
        HStack(spacing: 24) {
            SkillImageView(image: skillCategory.imageName, size: .small)
       
            HStack(alignment: .center) {
                Text(skillCategory.title)
                    .font(AppFonts.figtreeExBold16SwiftUI)
                    .foregroundStyle(.active)
                Spacer()

                EditButtonWithArrowView(text: NSLocalizedString("Edit",
                                                                tableName: "SkillsLocalization",
                                                                comment: ""))
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 14)
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

#Preview {
    let dataManager = SkillsDataManager()
    SkillGroupsView(skillCategories: testSkills[0].skillsGroups).environmentObject(dataManager)
}
