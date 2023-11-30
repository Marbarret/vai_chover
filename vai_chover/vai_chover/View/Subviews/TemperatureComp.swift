import SwiftUI

struct TemperatureComp: View {
    var imageName: String
    var title: String
    var temperature: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 148, height: 66)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .inset(by: 0.5)
                        .stroke(CustomTheme.primary200.color.opacity(0.3), lineWidth: 1)
                )
            
            HStack(spacing: 10) {
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(CustomTheme.fontMediumInter(size: 10))
                        .foregroundColor(CustomTheme.text200.color)
                    
                    Text("\(temperature)")
                        .foregroundColor(CustomTheme.text100.color)
                        .font(CustomTheme.fontBoldInter(size: 17))
                }
            }
        }
    }
}

