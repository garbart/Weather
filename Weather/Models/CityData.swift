//
//  CityData.swift
//  Weather
//
//  Created by Artem Garbart on 02.12.2022.
//

import Foundation

// MARK: - CityData
struct CityData: Codable {
    let id: Int
    let name, state, country: String
    let coord: Position
}

// MARK: - Position
struct Position: Codable {
    let lon, lat: Double
}
