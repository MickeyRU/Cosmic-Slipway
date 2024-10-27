import Foundation

final class SkillCellViewModel: ObservableObject {
    @Published var skill: Skill
    @Published var totalSP: Int = 0

    
    init(skill: Skill) {
          self.skill = skill
//          updateTotalSP()
      }
    
//    func updateTotalSP() {
//        Task {
//            let sp = await skill.getSPforCurrentLVL()
//            
//            await MainActor.run {
//                self.totalSP = sp
//            }
//        }
//    }
//    
//    func updateSkillLevel(to newLevel: CurrentSkillLevel) {
//        skill.updateLevel(to: newLevel, basedOn: allSkills)
//        updateTotalSP()
//    }
}
