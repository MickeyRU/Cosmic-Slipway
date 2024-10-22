import SwiftUI

struct SkillGroup: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let learnedPercent: Float
}

struct SkillsView: View {
    let skills = [
        SkillGroup(imageName: "cruisingTechnology", title: "Cruising Technology", learnedPercent: 25.3),
        SkillGroup(imageName: "maintenanceTechnology", title: "Maintenance Technology", learnedPercent: 16.2),
        SkillGroup(imageName: "electronics", title: "Electronics", learnedPercent: 15.0),
        SkillGroup(imageName: "weaponTechnology", title: "Weapon Technology", learnedPercent: 11.3),
        SkillGroup(imageName: "industrialTechnology", title: "Industrial Technology", learnedPercent: 0.0),
        SkillGroup(imageName: "socialScience", title: "Social Science", learnedPercent: 18.57),
        SkillGroup(imageName: "appliedScience", title: "Applied Science", learnedPercent: 0.0),
        SkillGroup(imageName: "naturalScience", title: "Natural Science", learnedPercent: 45.3),
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(.mainBG)
                    .resizable()
                    .ignoresSafeArea()
                List(skills) { skill in
                    SkillsGroupCell(skillGroup: skill)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                }
                .scrollIndicators(.hidden)
                .padding(.horizontal, 24)
                .listStyle(.plain)
                .clipped()
            }
        }
    }
}

struct SkillsGroupCell: View {
    var skillGroup: SkillGroup
    
    var body: some View {
        HStack(alignment: .top, spacing: 24) {
            GroupImage(imageName: skillGroup.imageName)
            VStack(alignment: .leading, spacing: 8) {
                Text(skillGroup.title)
                    .font(AppFonts.figtreeExBold16.swiftUIFont())
                    .foregroundStyle(.accent)
                Text("Learned: \(skillGroup.learnedPercent)" + "%")
                    .font(AppFonts.figtreeRegular12.swiftUIFont())
                    .foregroundStyle(.active)
                HStack {
                    NavigationLink(destination: SkillView(skillGroup: skillGroup.title)) {
                        HStack {
                            Spacer()
                            Text("Edit")
                                .font(AppFonts.figtreeExBold12.swiftUIFont())
                                .foregroundStyle(.active)
                            Image(.detailsButton)
                                .renderingMode(.template)
                                .foregroundStyle(.accent)
                        }
                    }
                }
            }
        }
        .padding(24)
        .background(Color.darkBG.opacity(0.5))
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

struct GroupImage: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [.gradientFrom, .gradientMiddle, .gradientTo]),
                    startPoint: .topTrailing,
                    endPoint: .bottomLeading
                )
                .blendMode(.darken)
            )
    }
}

#Preview {
    SkillsView()
}
