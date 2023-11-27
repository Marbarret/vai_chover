import Foundation
import Moya

class ProviderWeatherAPI {
    var providerApi: MoyaProvider<WeatherAPI>!
    init(isStub: Bool = false) {
        self.providerApi = isStub ? MoyaProvider<WeatherAPI>(stubClosure: MoyaProvider.immediatelyStub) : MoyaProvider<WeatherAPI>()
    }
}

enum WeatherAPI {
    case getWeather(latitude: Double, longitude: Double, apiKey: String)
    case getWeatherByCity(city: String)
}

extension WeatherAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.openweathermap.org/data/2.5/")!
    }
    
    var path: String {
        switch self {
        case .getWeather:
            return "weather"
        case .getWeatherByCity:
            return "weather"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case let .getWeather(latitude, longitude, apiKey):
            return .requestParameters(parameters: ["lat": latitude, "lon": longitude, "appid": apiKey], encoding: URLEncoding.queryString)
        case let .getWeatherByCity(city):
            return .requestParameters(parameters: ["q": city, "appid": "04abb87ff7de3f5bc0eabb61e318f6b6"], encoding: URLEncoding.queryString)
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
