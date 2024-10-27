import SwiftUI

struct SkillsCategoriesView: View {
    @ObservedObject private var viewModel: SkillCategoriesViewModel
    
    var body: some View {
        ZStack {
            ScreenBGImageView(image: .mainBG)
            
            List(viewModel.skillCategories) { skill in
                SkillGroupsCell(skillGroup: skill)
                    .listRowBackground(Color.clear)
            }
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .padding(.vertical, 1)
        }
    }
    
    init(viewModel: SkillCategoriesViewModel) {
        self.viewModel = viewModel
    }
}

struct SkillGroupsCell: View {
    let skillGroup: SkillsCategory
    
    var body: some View {
        ZStack {
            GroupInfoView(skillGroup: skillGroup)
            NavigationLink(destination: SkillGroupsView(skillCategories: skillGroup.skillsGroups)) {
                EmptyView()
            }
            .opacity(0)
        }
        .shadow(color: Color.pureBlack.opacity(0.2), radius: 6, x: 0, y: -4)
    }
}

struct GroupInfoView: View {
    let skillGroup: SkillsCategory
    
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
    SkillsCategoriesView(viewModel: SkillCategoriesViewModel(skillsDataManager: SkillsDataManager()))
}
