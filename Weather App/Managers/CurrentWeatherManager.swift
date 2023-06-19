//
//  CurrentWeatherManager.swift
//  Weather App
//
//  Created by Арт Строганов on 13.05.23.
//

import Foundation
import CoreLocation

class CurrentWeatherManager {
    func getCurrentWeather(latitude: CLLocationDegrees,
                           longtitude: CLLocationDegrees,
                           callback: @escaping (Result<WeatherBody, Error>) -> Void) async {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longtitude)&appid=\("cf7b57732c70f68bc8b3d4f0d5820c79")&units=metric") else { fatalError("Missing URL") }
        let urlRequest = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                fatalError("Error fetching")
            }
            let decodedWeather = try JSONDecoder().decode(WeatherBody.self, from: data)
            callback(.success(decodedWeather))
        } catch {
            callback(.failure(error))
        }
    }
}

//Unrealised method let a = CurrentWeatherManager()
// , completion: @escaping (weatherDecoded?, Error?) -> Void
//a.getCurrentWeather(latitude: 0, longtitude: 0) { weather, error in
//    if let error = error else {
//
//    }
//}
