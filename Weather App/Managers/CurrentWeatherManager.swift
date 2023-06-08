//
//  CurrentWeatherManager.swift
//  Weather App
//
//  Created by Арт Строганов on 13.05.23.
//

import Foundation
import CoreLocation

class CurrentWeatherManager {
    func getCurrentWeather(latitude: CLLocationDegrees, longtitude: CLLocationDegrees) async throws -> WeatherBody{
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longtitude)&appid=\("cf7b57732c70f68bc8b3d4f0d5820c79")&units=metric") else { fatalError("Missing URL") }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error fetching")
        }
        let decodedWeather = try JSONDecoder().decode(WeatherBody.self, from: data)
        return decodedWeather
        }
    }
//let a = CurrentWeatherManager()
// , completion: @escaping (weatherDecoded?, Error?) -> Void
//a.getCurrentWeather(latitude: 0, longtitude: 0) { weather, error in
//    if let error = error else {
//
//    }
//}
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
