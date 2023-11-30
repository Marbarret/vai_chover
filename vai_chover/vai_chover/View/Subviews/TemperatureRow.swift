import SwiftUI

struct TemperatureRow: View {
    var imageName: String
    var date: String
    var hour: String
    var temperature: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 70)
                .overlay {
                    CustomTheme.bg300.color
                }
                .cornerRadius(10)
            
            HStack(spacing: 50) {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45, height: 45)
                
                Text("\(temperature)")
                    .font(CustomTheme.fontBoldInter(size: 35))
                    .foregroundColor(CustomTheme.text100.color)
                
                VStack(alignment: .trailing, spacing: 5) {
                    Text(date)
                        .font(CustomTheme.fontSemiBoldInter(size: 15))
                        .foregroundColor(CustomTheme.text100.color)
                    
                    Text(hour)
                        .font(CustomTheme.fontBoldInter(size: 12))
                        .foregroundColor(CustomTheme.text100.color)
                }
            }
            .padding(.horizontal, 10)
        }
        .padding(.horizontal, 20)
    }
}
