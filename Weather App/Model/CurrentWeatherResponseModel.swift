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
struct WeatherBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse

    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }

    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}
