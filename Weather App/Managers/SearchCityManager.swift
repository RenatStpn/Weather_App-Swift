//
//  SearchCityManager.swift
//  Weather App
//
//  Created by Арт Строганов on 17.06.23.
//

import Foundation
class SearchCityManager {
    func getCity(currentCityState: String,
                 complition: @escaping (Result<CityResponse, Error>) -> Void) async {
        let headers = [
            "X-RapidAPI-Key": "f85ec30c64msh455349c2541b731p1ace1bjsnfc2bcf11214b",
            "X-RapidAPI-Host": "wft-geo-db.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/adminDivisions?namePrefix=\(currentCityState)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
    
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            do {
                let httpResponse = response as? HTTPURLResponse
                let decodedCitys = try JSONDecoder().decode(CityResponse.self, from: data!)
                complition(.success(decodedCitys))
            } catch {
                complition(.failure(error))
            }
        })

        dataTask.resume()
    }
}
