//
//  ViewController.swift
//  Weather
//
//  Created by Artem Garbart on 27.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var feelsLikeTempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    let networkWeatherManager = NetworkWeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkWeatherManager.onCompletion = { [weak self] weatherData in
            guard let self = self else { return }
            self.updateInterface(with: weatherData)
        }
        
        networkWeatherManager.fetchWeather(forCity: "Moscow")
    }


    @IBAction func searchButtonPressed(_ sender: Any) {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert)
    }
    
    func updateInterface(with weatherData: WeatherData) {
        DispatchQueue.main.async {
            self.weatherImage.image = UIImage(systemName: weatherData.systemIconNameString)
            self.tempLabel.text = weatherData.temperatureString
            self.feelsLikeTempLabel.text = weatherData.feelsLikeTemperatureString
            self.cityLabel.text = weatherData.cityName
        }
    }
}


extension ViewController {
    func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        ac.addTextField { tf in
            let cities = ["San Francisco", "Moscow", "New York", "Stambul", "Viena"]
            tf.placeholder = cities.randomElement()
        }
        
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                self.networkWeatherManager.fetchWeather(forCity: cityName)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(search)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
}

