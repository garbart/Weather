//
//  NetworkWeatherManager.swift
//  Weather
//
//  Created by Artem Garbart on 29.11.2022.
//

import Foundation
import CoreLocation

class NetworkWeatherManager {

    private let currentWeatherURL = "https://api.openweathermap.org/data/2.5/weather"
    private let session = URLSession(configuration: .default)
    
    func fetchWeather(forCity cityId: Int, onCompletion: @escaping (WeatherData) -> Void) {
        guard let url = URL(string: "\(currentWeatherURL)?id=\(cityId)&apikey=\(apiKey)&units=metric") else { return }
        print(url)
        performRequest(url: url, onCompletion: onCompletion)
    }
    
    func fetchWeather(forPosition position: CLLocationCoordinate2D, onCompletion: @escaping (WeatherData) -> Void) {
        guard let url = URL(string: "\(currentWeatherURL)?lat=\(position.latitude)&lon=\(position.longitude)&apikey=\(apiKey)&units=metric") else { return }
        performRequest(url: url, onCompletion: onCompletion)
    }
    
    func performRequest(url: URL, onCompletion: @escaping (WeatherData) -> Void) {
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            guard let _ = self,
                  let data = data,
                  let rawWeatherData: RawWeatherData = JSONParser.parse(fromData: data),
                  let weather = WeatherData(from: rawWeatherData) else {
                return
            }
            onCompletion(weather)
        }
        task.resume()
    }
}
