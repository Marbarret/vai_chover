import SwiftUI

struct TemperatureComp: View {
    var imageName: String
    var title: String
    var temperature: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(CustomTheme.text100.color)
                .frame(width: 30, height: 30)
            
            Text(title)
                .font(CustomTheme.fontRegularInter(size: 14))
                .foregroundColor(CustomTheme.text100.color)
            
            Text("\(temperature)C")
                .foregroundColor(CustomTheme.text100.color)
                .font(CustomTheme.fontBoldInter(size: 20))
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .padding(10)
        .background(CustomTheme.bg200.color)
        .cornerRadius(12)
    }
}
