import SwiftUI

struct CustomStepper: View {
    @Binding var level: CurrentSkillLevel
    
    private let range: ClosedRange<CurrentSkillLevel> = .zero ... .five
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Button(action: {
                if level.rawValue > range.lowerBound.rawValue {
                    level = CurrentSkillLevel(rawValue: level.rawValue - 1) ?? .zero
                }
            }) {
                Image(.minusButton)
                    .resizable()
                    .frame(width: 44, height: 44)
                    .contentShape(Rectangle())
            }
            
            VStack(alignment: .center) {
                HStack(spacing: 2) {
                    Text("Level:")
                    Text("\(level.rawValue)")
                        .monospacedDigit()
                }
                    .font(AppFonts.figtreeRegular12SwiftUI)
                    .foregroundStyle(.iconText)
                    .frame(minWidth: 50)
                
                HStack(spacing: 4) {
                    ForEach(0..<5) { index in
                        Rectangle()
                            .fill(index < level.rawValue ? .accent : .iconText)
                            .frame(width: 5, height: 5)
                    }
                }           
            }
            
            Button(action: {
                if level.rawValue < range.upperBound.rawValue {
                    level = CurrentSkillLevel(rawValue: level.rawValue + 1) ?? .five
                }
            }) {
                Image(.addButton)
                    .resizable()
                    .frame(width: 44, height: 44)
                    .contentShape(Rectangle())
            }
        }
    }
}

#Preview {
    CustomStepper(level: .constant(.zero))
}
