import Foundation

struct WeatherModel {
    let conditionID: Int
    let temp: Double
    let name: String
    let maxtemp: Double
    let mintemp: Double
    let speed: Double
    let humidity: Int
        
    var tempString: String {
        return String(format: "%.0f", temp)
    }
    
    var maxTempString: String {
        return String(format: "%.0f", maxtemp)
    }
    
    var mintempString: String {
        return String(format: "%.0f", mintemp)
    }
    
    var speedString: String {
        return String(format: "%.0f", speed)
    }
    
    var conditionName: String {
        switch conditionID {
        case 200...232:
            return "thunder"
        case 300...321:
            return "rain"
        case 500...531:
            return "clouds"
        case 600...622:
            return "clound-snow"
        case 701...781:
            return "sunClound"
        case 800:
            return "sun"
        case 801...804:
            return "sunClound-2"
        default:
            return "clouds"
        }
    }
}
