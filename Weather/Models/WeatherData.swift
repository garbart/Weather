//
//  Weather.swift
//  Weather
//
//  Created by Artem Garbart on 29.11.2022.
//

import Foundation


struct WeatherData {
    let cityName: String
    
    let temperature: Double
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    
    let feelsLikeTemperature: Double
    var feelsLikeTemperatureString: String {
        return String(format: "%.0f", feelsLikeTemperature)
    }
    
    let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.max.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }
    
    init?(from rawWeatherData: RawWeatherData) {
        cityName = rawWeatherData.name
        temperature = rawWeatherData.main.temp
        feelsLikeTemperature = rawWeatherData.main.feelsLike
        conditionCode = rawWeatherData.weather.first!.id
    }
}
