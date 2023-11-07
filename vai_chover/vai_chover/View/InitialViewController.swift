import UIKit
import CoreLocation

class InitialViewController: UIViewController {

    @IBOutlet weak var temperatura: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.requestWhenInUseAuthorization()
        
        weatherManager.delegate = self
    }
    @IBAction func locPress(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

extension InitialViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            weatherManager.fetchWeather(lat, long)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("===> Esse Error \(error)")
    }
}

extension InitialViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatura.text = weather.name
//            self.imgView.image = UIImage(named: weather.conditionName)
//            self.cityName.text = weather.name
//            self.mxmTemp.text = "\(weather.maxTempString)°C"
//            self.minTemp.text = "\(weather.mintempString)°C"
//            self.speedLabel.text = "\(weather.speedString)m/s"
//            self.humidityLabel.text = "\(weather.humidity)%"
//
//            self.cityInformations.text = "Today \(Date().dateFormatter(style: .medium)!)"
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}
