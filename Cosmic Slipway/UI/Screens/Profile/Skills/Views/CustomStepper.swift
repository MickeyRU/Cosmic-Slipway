import SwiftUI

struct CustomStepper: View {
    let level: CurrentSkillLevel
    
    var onIncrement: () -> Void
    var onDecrement: () -> Void
    
    private let range: ClosedRange<CurrentSkillLevel> = .zero ... .five
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Button(action: onDecrement) {
                Image(.minusButton)
                    .resizable()
                    .frame(width: 44, height: 44)
                    .contentShape(Rectangle())
            }
            
            VStack(alignment: .center) {
                HStack(spacing: 2) {
                    Text(NSLocalizedString("Level:", tableName: "SkillsLocalization", comment: ""))
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
            
            Button(action: onIncrement) {
                Image(.addButton)
                    .resizable()
                    .frame(width: 44, height: 44)
                    .contentShape(Rectangle())
            }
        }
    }
}
