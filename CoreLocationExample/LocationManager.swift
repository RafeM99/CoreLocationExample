//
//  LocationManager2.swift
//  CoreLocationExample
//
//  Created by Rafe Marriott on 12/03/2025.
//

import SwiftUI
import CoreLocation

@Observable
class LocationManager2: NSObject, CLLocationManagerDelegate {
    @ObservationIgnored let manager = CLLocationManager()
    
    var userLocation: CLLocation?
    var isAuthorised: Bool = false
    
    override init() {
        super.init()
        manager.delegate = self
        startLocationServices()
    }
    
    func startLocationServices() {
        if manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse {
            manager.startUpdatingLocation()
            isAuthorised = true
        } else {
            isAuthorised = false
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            isAuthorised = true
            manager.requestLocation()
        case .notDetermined:
            isAuthorised = false
            manager.requestWhenInUseAuthorization()
        case .denied:
            isAuthorised = false
            print("access denied")
        default:
            isAuthorised = true
            startLocationServices()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
}
