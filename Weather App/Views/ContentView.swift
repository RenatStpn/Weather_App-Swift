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
    @State var currentWeather: WeatherBody?
    var body: some View {
        VStack {
            if let coordinates = locationManager.coordinates {
                if let currentWeather = currentWeather {
                    CurrentWeatherView(currentWeather: currentWeather)
                }
                else {
                    LoadingView()
                        .task {
                            do {
                                currentWeather  = try await weatherManager.getCurrentWeather(latitude: coordinates.latitude, longtitude: coordinates.longitude)
                            } catch {
                                print("ERROR FETCHING DATA \(error)")
                            }
                        }
                }
            } else if locationManager.isLoading {
                LoadingView()
            } else {
                MainScreenView().environmentObject(locationManager)
            }
            
        }.background(Color(hue: 0.665, saturation: 0.651, brightness: 0.347)).preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

