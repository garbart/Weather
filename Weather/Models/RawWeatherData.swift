//
//  WeatherData.swift
//  Weather
//
//  Created by Artem Garbart on 29.11.2022.
//

import Foundation

// MARK: - RawWeatherData
struct RawWeatherData: Codable {
    let name: String
    let weather: [Weather]
    let main: Main
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
}
