import SwiftUI

enum WeatherCondition: String {
    case clearSky = "Clear"
    case clouds = "Clouds"
    case showerRain = "showerRain"
    case rain = "Rain"
    case thunderstorm = "Thunderstorm"
    case snow = "Snow"
    case mist = "Mist"
    
    case clearNight = "ClearNight"
    case cloudyNight = "CloudyNight"
    case showerRainNight = "ShowerRainNight"
    case rainNight = "RainNight"
    case thunderstormNight = "ThunderstormNight"
    case snowNight = "SnowNight"
    case mistNight = "MistNight"
    
    init(description: String, isNight: Bool = false) {
        let lowercasedDescription = description.lowercased()
        
        switch lowercasedDescription {
        case "clear_sky":
            self = isNight ? .clearNight : .clearSky
        case "clouds", "overcast clouds":
            self = isNight ? .cloudyNight : .clouds
        case "shower rain":
            self = isNight ? .showerRainNight : .showerRain
        case "rain":
            self = isNight ? .rainNight : .rain
        case "thunderstorm":
            self = isNight ? .thunderstormNight : .thunderstorm
        case "snow":
            self = isNight ? .snowNight : .snow
        case "mist":
            self = isNight ? .mistNight : .mist
        default:
            self = isNight ? .clearNight : .clearSky
        }
    }
    
    var imageName: String {
        return rawValue.lowercased()
    }
    
    var image: Image {
        Image(imageName)
    }
}
