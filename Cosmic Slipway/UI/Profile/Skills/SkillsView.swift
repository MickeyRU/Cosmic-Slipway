import SwiftUI

struct SkillsView: View {
    let skills: [Skill]
    
    var body: some View {
        ZStack {
            ScreenBGImageView(image: .mainBG)
            
            List(skills) { skill in
                SkillCellView(skill: skill)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                    .buttonStyle(.plain)
            }
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .padding()
        }
    }
}

struct SkillCellView: View {
    let skill: Skill
    
    var body: some View {
        HStack(spacing: 20) {
            SkillImageView(image: skill.imageName, size: .regular)
            
            VStack(alignment: .leading){
                Text(skill.title)
                    .font(AppFonts.figtreeExBold16SwiftUI)
                    .foregroundStyle(.active)
                HStack {
                    Text("SP: 20 156 095")
                        .font(AppFonts.figtreeRegular12SwiftUI)
                        .foregroundStyle(.iconText)
                    
                    Spacer()
                    
                    CustomStepper()
                        .fixedSize()
                }
            }
        }
        
        .padding(.horizontal, 24)
        .padding(.vertical, 14)
        .background(Color.darkBG.opacity(0.6))
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .shadow(color: Color.pureBlack.opacity(0.3), radius: 6, x: 0, y: -4)
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
    SkillsView(skills: testSkills[0].skillsCategories[0].skills)
}
