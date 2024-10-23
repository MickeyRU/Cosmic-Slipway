import SwiftUI

struct SkillsGroupView: View {
    var body: some View {
        ZStack {
            ScreenBGImageView(image: .mainBG)
            
            List(testSkills) { skill in
                SkillsGroupCell(skillGroup: skill)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            }
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .padding()
        }
    }
}

struct SkillsGroupCell: View {
    let skillGroup: SkillGroup
    
    var body: some View {
        ZStack {
            GroupInfoView(skillGroup: skillGroup)
            NavigationLink(destination: SkillsCategoryView(skillsCategories: skillGroup.skillsCategories)) {
                EmptyView()
            }
            .opacity(0)
        }
        .shadow(color: Color.pureBlack.opacity(0.4), radius: 6, x: 0, y: -4)
    }
}

struct GroupInfoView: View {
    let skillGroup: SkillGroup
    
    var body: some View {
        HStack(alignment: .center, spacing: 24) {
            SkillImageView(image: skillGroup.imageName, size: .regular)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(skillGroup.title)
                        .font(AppFonts.figtreeExBold16SwiftUI)
                        .foregroundStyle(.accent)
                }
                
                HStack (alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Learned: \(skillGroup.learnedPercent)" + "%")
                        Text("Total SP: \(skillGroup.learnedSP)")
                    }
                    .font(AppFonts.figtreeRegular12SwiftUI)
                    .foregroundStyle(.iconText)
                    
                    Spacer()
                    
                    EditButtonWithArrowView(text: "Edit")
                }
            }
            
        }
        .padding(24)
        .background(Color.darkBG.opacity(0.6))
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
    SkillsGroupView()
}
