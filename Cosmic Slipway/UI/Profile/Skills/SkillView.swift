import SwiftUI

struct SkillView: View {
    var skillGroup: String
    
    var body: some View {
        Text("Hello, World!")
        Text(self.skillGroup)
    }
    
}

#Preview {
    SkillView(skillGroup: "Skill")
}
