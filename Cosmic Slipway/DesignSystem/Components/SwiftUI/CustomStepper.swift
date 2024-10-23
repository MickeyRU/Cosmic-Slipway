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
                    .padding(8)
                    .contentShape(Rectangle())
            }
            
            VStack(alignment: .center, spacing: 8) {
                Text("Level: \(level)")
                    .font(AppFonts.figtreeRegular12SwiftUI)
                    .foregroundStyle(.iconText)
                
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
                    .padding(8)
                    .contentShape(Rectangle())
            }
        }
        .background(Color.clear)  // Чтобы убедиться, что контейнер не блокирует касания
    }
}

#Preview {
    CustomStepper()
}
