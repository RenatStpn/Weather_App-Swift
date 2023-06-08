//
//  WeatherResponseModel.swift
//  Weather App
//
//  Created by Арт Строганов on 13.05.23.
//

import Foundation
var previewWeather: WeatherBody  = getDataFromJSON("WeatherData.json")
func getDataFromJSON(_ filename: String) -> WeatherBody{
    let jsonData: Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
        fatalError("No such file as \(filename)")
    }
    jsonData = try! Data(contentsOf: file)
  
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(WeatherBody.self, from: jsonData)
    } catch {
        fatalError("Couldn't parse data")
    }
}
