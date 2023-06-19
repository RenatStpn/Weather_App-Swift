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
var previewCitys: CityResponse = getDataFromJSON("citys.json")
func getDataFromJSON(_ filename: String) -> CityResponse{
    let jsonData: Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
        return CityResponse(data: [], links: [])
    }
    jsonData = try! Data(contentsOf: file)
  
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(CityResponse.self, from: jsonData)
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
struct CityResponse: Decodable {
    struct City: Decodable, Identifiable {
        var id: Int
        var wikyDataId: String
        var name : String
        var country: String
        var countryCode: String
        var region: String
        var regionCode: String
        var regionWdId: String
        var latitude: Double
        var longtitude:Double
        var population: Int
    }
    struct Links: Decodable {
        var rel: String
        var href: String
    }
    var data: [City]
       
    var links: [Links]
        
    struct metadata: Decodable {
        var currentOffset: Int
        var totalCount: Int
      }
    }
