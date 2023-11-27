import Foundation

class WeatherService {
    var provider: ProviderWeatherAPI
    
    init(providerApi: ProviderWeatherAPI){
        self.provider = providerApi
    }
    
    func getWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let dispatchGroup = DispatchGroup()
        
        var weatherResponse: WeatherResponse?
        var error: Error?
        
        dispatchGroup.enter()
        provider.providerApi.request(.getWeather(latitude: latitude, longitude: longitude, apiKey: "04abb87ff7de3f5bc0eabb61e318f6b6")) { result in
            switch result {
            case let .success(response):
                do {
                    weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: response.data)
                } catch let decodingError {
                    error = decodingError
                }
            case let .failure(apiError):
                error = apiError
            }
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            if let weatherResponse = weatherResponse {
                completion(.success(weatherResponse))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func getWeatherByCity(city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        provider.providerApi.request(.getWeatherByCity(city: city)) { result in
            switch result {
            case let .success(response):
                do {
                    let weather = try JSONDecoder().decode(WeatherResponse.self, from: response.data)
                    completion(.success(weather))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
