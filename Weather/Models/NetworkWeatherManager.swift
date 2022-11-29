//
//  NetworkWeatherManager.swift
//  Weather
//
//  Created by Artem Garbart on 29.11.2022.
//

import Foundation

class NetworkWeatherManager {

    var onCompletion: ((WeatherData) -> Void)?
    
    func fetchWeather(forCity cityName: String) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&apikey=\(apiKey)&units=metric") else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            guard let rawWeatherData = self.parseJSON(withData: data) else { return }
            guard let weather = WeatherData(from: rawWeatherData) else { return }
            self.onCompletion?(weather)
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) -> RawWeatherData? {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(RawWeatherData.self, from: data)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
