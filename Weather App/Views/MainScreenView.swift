//
//  MainScreenView.swift
//  Weather App
//
//  Created by Арт Строганов on 07.05.23.
//

import SwiftUI
import CoreLocationUI
struct MainScreenView: View {
    @EnvironmentObject var locationManager: LocationManager
    var body: some View {
        VStack {
            Text("Weather App").font(.title).bold()
            Text("By Renat Stepanian").font(.caption)
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }.foregroundColor(.white).cornerRadius(30)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
