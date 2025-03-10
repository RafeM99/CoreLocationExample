//
//  ContentView.swift
//  CoreLocationExample
//
//  Created by Rafe Marriott on 10/03/2025.
//

import SwiftUI
import MapKit


struct ContentView: View {
    // call your location Manager
    @State private var locationDataManager = LocationManager()
    
    @State private var latitude: Double = 0
    @State private var longitude: Double = 0
    @State private var cityN:String = ""
    @State private var countryC:String = ""

    var body: some View {
        
        VStack {
            Map {
                Annotation("Chapel", coordinate: .chapel, content: {
                    Image(systemName: "building.columns")
                        .padding(4)
                        .foregroundColor(.white)
                        .background(.indigo)
                        .cornerRadius(4)
                })
            }
            
            Text("City : \(cityN)")
                .font(.system(size: 28, weight: .bold))
            Text("Country : \(countryC)")
                .font(.system(size: 28, weight: .bold))
            Text("Latitude : \(latitude)")
                .font(.system(size: 28, weight: .bold))
            Text("Longitude : \(longitude)")
                .font(.system(size: 28, weight: .bold))

        } // End Vstack
        
        .onAppear(){
            // latitude and longitude
            let yourLatitudeString = String(locationDataManager.locationManager.location?.coordinate.latitude.description ?? "Error loading")
            let yourLongitudeString = String(locationDataManager.locationManager.location?.coordinate.longitude.description ?? "Error loading")
            self.latitude = (Double(yourLatitudeString) ?? 0)
            self.longitude =  (Double(yourLongitudeString) ?? 0)
        // city and country
            let locationInfo = LocationInfo()
            locationInfo.getCityAndCountryLocation(latitude: self.latitude, longitude: self.longitude) { city, country in
                if let city = city, let country = country {
                    self.cityN = city
                    self.countryC = country
                    print("City: \(city), Country: \(country)")
                } else {
                    print("Unable to fetch location information.")
                }
            }
        }

       
        
    }
}

#Preview {
    ContentView()
}
