//
//  Common.swift
//  Weather
//
//  Created by Artem Garbart on 02.12.2022.
//

import Foundation


class JSONParser {
    
    private static let jsonDecoder = JSONDecoder()
    
    static func parse<DataType: Codable>(fromData data: Data) -> DataType? {
        do {
            return try jsonDecoder.decode(DataType.self, from: data)
        } catch let error as NSError {
            print(error.description)
        }
        return nil
    }
    
    static func parse<DataType: Codable>(fromJSONFile fileName: String) -> DataType? {
        do {
            if let filePath = Bundle.main.path(forResource: fileName, ofType: "json"),
               let data = try String(contentsOfFile: filePath).data(using: .utf8) {
                return parse(fromData: data)
            }
        } catch {}
        return nil
    }
    
}
