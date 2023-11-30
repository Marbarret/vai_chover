import SwiftUI

struct WeatherInformations: View {
    var temperature: String
    var date: String
    var city: String
    var previsionRain: String
    var image: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(temperature)
                    .foregroundColor(CustomTheme.text300.color)
                    .font(CustomTheme.fontBlacktInter(size: 50))
                    .bold()
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(date)
                        .foregroundColor(CustomTheme.text200.color)
                        .font(CustomTheme.fontLightInter(size: 12))
                    
                    Text(city)
                        .foregroundColor(CustomTheme.text300.color)
                        .font(CustomTheme.fontBoldInter(size: 20))
                }
                .padding(.top, 10)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Previsão de chuva")
                        .font(CustomTheme.fontLightInter(size: 12))
                        .foregroundColor(CustomTheme.text100.color)
                    
                    Text(previsionRain)
                        .foregroundColor(CustomTheme.text100.color)
                        .font(CustomTheme.fontBoldInter(size: 20))
                }
                .padding(.top, 10)
            }
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 160, height: 139)
        }
    }
}
