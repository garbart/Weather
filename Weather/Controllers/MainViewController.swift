//
//  ViewController.swift
//  Weather
//
//  Created by Artem Garbart on 27.11.2022.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    @IBOutlet private weak var weatherImage: UIImageView!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var feelsLikeTempLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    
    private let networkWeatherManager = NetworkWeatherManager()
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func updateInterface(with weatherData: WeatherData) {
        DispatchQueue.main.async {
            self.weatherImage.image = UIImage(systemName: weatherData.systemIconNameString)
            self.tempLabel.text = weatherData.temperatureString
            self.feelsLikeTempLabel.text = weatherData.feelsLikeTemperatureString
            self.cityLabel.text = weatherData.cityName
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let citySearchVC = segue.destination as! CitySearchViewController
        citySearchVC.updateWeather = { [weak self] city in
            if let self = self {
                self.networkWeatherManager.fetchWeather(forCity: city.id, onCompletion: self.updateInterface)
            }
        }
    }
}


extension MainViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {}
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let position = locations.last?.coordinate else { return }
        networkWeatherManager.fetchWeather(forPosition: position, onCompletion: updateInterface)
    }
}
