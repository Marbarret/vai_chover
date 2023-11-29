import SwiftUI
import CoreLocation

class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse?
    @Published var isLoading: Bool = false
    @Published var userLocation: CLLocation?
    @Published var currentWeatherCondition: WeatherCondition = .clearSky
    
    var system: Int = 0
    let weatherService = WeatherService(providerApi: ProviderWeatherAPI())
    
    func fetchWeatherForecast(for location: String) {
        getWeatherForecast(location: location)
    }
    
    func fetchCity(_ city: String) {
        weatherService.getWeatherByCity(city: city) { result in
            switch result {
            case .success(let response):
                self.weather = response
            case .failure(let failure):
                self.handleError(failure)
            }
        }
    }
    
    func fetchWeather() {
        guard let location = userLocation else {
            print("User location is not available.")
            return
        }
        
        weatherService.getWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { result in
            switch result {
            case .success(let response):
                self.weather = response
            case .failure(let failure):
                self.handleError(failure)
            }
        }
    }
    
    private func updateWeatherCondition(description: String) {
        let isNight = isNightTime()
        currentWeatherCondition = WeatherCondition(description: description, isNight: isNight)
    }
    
    private func isNightTime() -> Bool {
        let currentDate = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentDate)
        return hour < 6 || hour >= 18
    }
    
    private func getWeatherForecast(location: String) {
        isLoading = true
        
        CLGeocoder().geocodeAddressString(location) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
            if let error = error as? CLError {
                self.handleError(error)
                return
            }
            
            guard let location = placemarks?.first?.location else {
                self.handleError(NSLocalizedString("Unable to determine location from this text.", comment: "") as! Error)
                return
            }
            
            self.weatherService.getWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    self.handleWeatherResponse(response)
                case .failure(let apiError):
                    self.handleError(apiError)
                }
            }
        }
    }
    
    private func handleWeatherResponse(_ weather: WeatherResponse) {
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = false
            self?.weather = weather
        }
    }
    
    private func handleError(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = false
            print(error.localizedDescription)
        }
    }
    
    let weeklyDay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d/M"
        return formatter
    }()
    
    func hasRainForecast() -> Bool {
        guard let forecasts = weather?.list else {
            return false
        }

        for forecast in forecasts {
            if let rain = forecast.rain {
                return rain.the3H > 0
            }
        }

        return false
    }

    func calculateRainProbability() -> Int {
        guard let forecasts = weather?.list else {
            return 0
        }

        var rainProbability = 0

        for forecast in forecasts {
            if let rain = forecast.rain {
                rainProbability += Int(rain.the3H)
            }

            if let weatherCondition = forecast.weather.first,
               weatherCondition.main == .rain {
                rainProbability += 50
            }

            if let weatherCondition = forecast.weather.first,
               weatherCondition.description.lowercased().contains("light") {
                rainProbability += 20
            }
        }
        return min(max(rainProbability, 0), 100)
    }
}

extension WeatherViewModel {
    func formattedTime(from string: String,  timeZoneOffset: Double) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/YY"
        
        if let date = inputFormatter.date(from: string) {
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone(secondsFromGMT: Int(timeZoneOffset))
            return weeklyDay.string(from: date)
        }
        return nil
    }
    
    func formattedHourlyTime(time: Double, timeZoneOffset: Double) -> String {
        let date = Date(timeIntervalSince1970: time)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: Int(timeZoneOffset))
        return formatter.string(from: date)
    }
    
    func convert(_ temp: Double) -> Double {
        let celsius = temp - 273.5
        if system == 0 {
            return celsius
        } else {
            return celsius * 9 / 5 + 32
        }
    }
    
    var temperature: String {
        return "\(Self.numberFormatter.string(for: convert(weather?.list[0].main.temp ?? 0.0)) ?? "0")°"
    }
    
    var high: String {
        return "\(Self.numberFormatter.string(for: convert(weather?.list[0].main.tempMax ?? 0.0)) ?? "0")°"
    }
    
    var low: String {
        return "\(Self.numberFormatter.string(for: convert(weather?.list[0].main.tempMin ?? 0.0)) ?? "0")°"
    }
    
    var name: String {
        return weather?.city.name ?? ""
    }
    
    var day: String {
        return weeklyDay.string(from: Date(timeIntervalSince1970: TimeInterval(weather?.list[0].dt ?? 0)))
    }
    
    var feels: String {
        return "\(Self.numberFormatter.string(for: convert(weather?.list[0].main.feelsLike ?? 0)) ?? "0")°"
    }
    
    var clouds: String {
        return "\(String(describing: weather?.list[0].clouds ?? .none))%"
    }
    //
    //    var humidity: String {
    //        return "\(weather?.main.humidity.roundDouble())%"
    //    }
    //
    var wind: String {
        return "\(Self.numberFormatter.string(for: weather?.list[0].wind) ?? "0")m/s"
        //        return "\(Self.numberFormatter.string(for: weather?.wind.speed) ?? "0")m/s"
    }
    
    static var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }
}
