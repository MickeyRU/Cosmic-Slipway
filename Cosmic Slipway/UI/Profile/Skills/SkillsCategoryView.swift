import SwiftUI

struct SkillsCategoryView: View {
    let skillsCategories: [SkillsCategory]
    
    var body: some View {
        ZStack {
            ScreenBGImageView(image: .mainBG)
            
            List(skillsCategories) { skillCategory in
                GroupCellView(skillCategory: skillCategory)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            }
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .padding()
        }
    }
}

struct GroupCellView: View {
    let skillCategory: SkillsCategory
    
    var body: some View {
        ZStack {
            CategoryInfoView(skillCategory: skillCategory)
            NavigationLink(destination: SkillsView(skills: skillCategory.skills)) {
                EmptyView()
            }
            .opacity(0)
        }
    }
}

struct CategoryInfoView: View {
    let skillCategory: SkillsCategory

    var body: some View {
        HStack(spacing: 24) {
            SkillImageView(image: skillCategory.imageName, size: .regular)
       
            HStack(alignment: .center) {
                Text(skillCategory.title)
                    .font(AppFonts.figtreeExBold16SwiftUI)
                    .foregroundStyle(.active)
                Spacer()

                EditButtonWithArrowView(text: "Edit")
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 14)
        .background(Color.darkBG.opacity(0.6))
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .stroke(LinearGradient(
                    gradient: Gradient(colors: [
                        Color(UIColor.gradientFrom),
                        Color(UIColor.gradientMiddle),
                        Color(UIColor.gradientTo)
                    ]),
                    startPoint: .init(x: 0.9, y: 0),
                    endPoint: .init(x: 0.1, y: 1)
                ), lineWidth: 1)
        )
    }
}

#Preview {
    SkillsCategoryView(skillsCategories: testSkills[0].skillsCategories)
}
