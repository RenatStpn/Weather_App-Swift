//
//  LocationManager.swift
//  Weather App
//
//  Created by Арт Строганов on 07.05.23.
//

import Foundation
import CoreLocation
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate{
    let locationManager = CLLocationManager()
    @Published var coordinates: CLLocationCoordinate2D?
    @Published var isLoading: Bool = false
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        isLoading = true
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        coordinates = locations.first?.coordinate
        isLoading = false
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        isLoading = false
        print("Couldn't get the location", error)
    }
    
}
