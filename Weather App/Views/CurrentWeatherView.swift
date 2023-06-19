//
//  CurrentWeatherView.swift
//  Weather App
//
//  Created by Арт Строганов on 14.05.23.
//

import SwiftUI

struct CurrentWeatherView: View {
    var currentWeather: WeatherBody
    var body: some View {
        VStack{
    
            VStack {
                Text(currentWeather.name).font(.largeTitle).bold()
                Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                                        .fontWeight(.light)
            }
            
            Text(DoubleRoundedToString(currentWeather.main.feels_like) + "º").font(.largeTitle)
            HStack(spacing: 5) {
                Text("Max: \(DoubleRoundedToString(currentWeather.main.temp_max))").fontWeight(.light)
                Text("Min:  \(DoubleRoundedToString(currentWeather.main.temp_min))").fontWeight(.light)
            }
        }.frame(maxWidth: .infinity, maxHeight:.infinity)
    }
 
}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView(currentWeather: previewWeather)
    }
}
