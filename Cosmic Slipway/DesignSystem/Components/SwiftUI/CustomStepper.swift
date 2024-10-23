import SwiftUI

struct CustomStepper: View {
    @State private var level: Int = 0
    
    private let range: ClosedRange<Int> = 0...5
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Button(action: {
                if level > range.lowerBound {
                    level -= 1
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
                    Text("\(level)")
                        .monospacedDigit()
                }
                    .font(AppFonts.figtreeRegular12SwiftUI)
                    .foregroundStyle(.iconText)
                    .frame(minWidth: 50)
                
                HStack(spacing: 4) {
                    ForEach(0..<5) { index in
                        Rectangle()
                            .fill(index < level ? .accent : .iconText)
                            .frame(width: 5, height: 5)
                    }
                }           
            }
            
            Button(action: {
                if level < range.upperBound {
                    level += 1
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
    CustomStepper()
}
