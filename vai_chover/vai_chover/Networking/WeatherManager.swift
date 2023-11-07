import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel)
    func didFailWithError(_ error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=04abb87ff7de3f5bc0eabb61e318f6b6&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchCity(_ cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString)
    }
    
    func fetchWeather(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString)
    }
    
    func performRequest(_ urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, err) in
                if err != nil {
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let maxTemp = decodedData.main.temp_max
            let minTemp = decodedData.main.temp_min
            let speed = decodedData.wind.speed
            let humidity = decodedData.main.humidity
            
            let weather = WeatherModel(conditionID: id, temp: temp, name: name, maxtemp: maxTemp, mintemp: minTemp, speed: speed, humidity: humidity)
            return weather
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}
