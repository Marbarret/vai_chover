import SwiftUI

struct FakeInitialView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @AppStorage("isDarkModeOn") private var isDarkModeOn: Bool = false
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        BackgroundView {
            VStack {
                HeaderView(viewModel: viewModel) { location in
                    viewModel.userLocation = location
                    viewModel.fetchWeather()
                }
                .padding(.horizontal, 20)
                .padding(.top, UIApplication
                    .shared
                    .connectedScenes
                    .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                    .first { $0.isKeyWindow }?.safeAreaInsets.top)
                
                VStack(alignment: .leading, spacing: 5) {
                        WeatherInformations(temperature: "0°C",
                                            date: "00/00",
                                            city: "City",
                                            previsionRain: "0%",
                                            image: "clear")
                }
                .frame(maxWidth: .infinity, maxHeight: 165)
                .foregroundStyle(Color.white)
                .contentShape(Rectangle())
                .padding(.horizontal, 20)
                
                HStack(spacing: 44) {
                    TemperatureComp(imageName: "thermometer.high", title: "Max", temperature: "0°C")
                    TemperatureComp(imageName: "thermometer.low", title: "Min", temperature: "0°C")
                }
                .padding(.top, 30)
                
                HStack {
                    Text("Diário")
                        .foregroundColor(CustomTheme.text300.color)
                        .font(CustomTheme.fontExtraBoldInter(size: 20))
                    Spacer()
                }
                .padding(.top, 30)
                .padding(.horizontal, 20)
                    TemperatureRow(imageName: "clear_sky",
                                   date: "00/00/0000",
                                   hour: "00:00",
                                   temperature: "0°C")
                Spacer()
                
                FooterView(isDarkModeOn: $isDarkModeOn)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .preferredColorScheme(isDarkModeOn ? .dark : .light)
    }
}
