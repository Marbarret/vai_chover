import SwiftUI
import CoreLocation

struct InitialView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @AppStorage("isDarkModeOn") private var isDarkModeOn: Bool = false
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
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
                    WeatherInformations(temperature: viewModel.temperature,
                                        date: viewModel.date,
                                        city: viewModel.name,
                                        previsionRain: "\(viewModel.calculateRainProbability())%",
                                        image: viewModel.currentWeatherCondition.imageName)
                }
                .frame(maxWidth: .infinity, maxHeight: 165)
                .foregroundStyle(Color.white)
                .contentShape(Rectangle())
                .padding(.horizontal, 20)
                
                HStack(spacing: 44) {
                    
                    TemperatureComp(imageName: "thermometer.high", title: "Max", temperature: viewModel.high)
                    TemperatureComp(imageName: "thermometer.low", title: "Min", temperature: viewModel.low)
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
                ForEach(viewModel.hourlyWeather.prefix(4), id: \.self) { hourly in
                    TemperatureRow(imageName: "clear_sky",
                                   date: viewModel.dateFor3Times,
                                   hour: "\(hourly.date)",
                                   temperature: "\(hourly.temperature)")
                }
                Spacer()
                
                FooterView(isDarkModeOn: $isDarkModeOn)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .preferredColorScheme(isDarkModeOn ? .dark : .light)
    }
}
