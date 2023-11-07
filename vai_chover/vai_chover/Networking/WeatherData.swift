import Foundation

struct WeatherData: Codable {
    let name: String
    let main: MainData
    let weather: [Weather]
    let wind: WindData
    let timezone: Int
}

struct MainData: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
}

struct Weather: Codable {
    let id: Int
    let description: String
}

struct WindData: Codable {
    let speed: Double
}
