//
//  ContentView.swift
//  Weather App
//
//  Created by Арт Строганов on 06.05.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = CurrentWeatherManager()
    var citysManager = SearchCityManager()
    @State var currentWeather: WeatherBody?
    @State var cityList: CityResponse?
    @State private var queryString = ""
    var body: some View {
        NavigationView {
            VStack {
                if let coordinates = locationManager.coordinates {
                    if let currentWeather = currentWeather {
                        CurrentWeatherView(currentWeather: currentWeather)
                    } else if let cityList = cityList {
                        MainScreenView(cityList: cityList)
                    }
                    else {
                        LoadingView()
                            .task {
                                await weatherManager.getCurrentWeather(
                                    latitude: coordinates.latitude,
                                    longtitude: coordinates.longitude,
                                    callback: { result in
                                        switch result {
                                        case .success(let weatherData):
                                            // do something with weather data
                                            currentWeather = weatherData
                                        case .failure(let error):
                                            // Show error in ErrorView
                                            break;
                                        }
                                    })
                            }
                    }
                } else if locationManager.isLoading {
                    LoadingView()
                } else {
                    MainScreenView(cityList: previewCitys).environmentObject(locationManager)
                }
                
            }.background(Color(hue: 0.665, saturation: 0.651, brightness: 0.347)).preferredColorScheme(.dark)
        }.searchable(text: $queryString, prompt: "Find your city").onChange(of: queryString) { newValue in
            autocomplete(text: newValue)
        }
    }
    func autocomplete(text: String) {
        Task{
           await citysManager.getCity(
               currentCityState: queryString,
               complition: {
                   result in switch result {
                   case .success(let citysData):
                       cityList = citysData
                   case .failure(let error):
                       break;
                   }
           })
        }
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
