//
//  ContentView.swift
//  CoreLocationExample
//
//  Created by Rafe Marriott on 10/03/2025.
//

import SwiftUI
import MapKit
import SwiftData

struct ContentView: View {
    // call your location Manager
    @State private var locationDataManager = LocationManager()
    @State private var showingSheet: Bool = false
    
    let manager = CLLocationManager()
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @Query private var listPlacemarks: [MKPlacemark]
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            Map(position: $cameraPosition) {
                UserAnnotation()
                
                Annotation("Chapel", coordinate: .chapel, content: {
                    Image(systemName: "building.columns")
                        .padding(4)
                        .foregroundColor(.white)
                        .background(.cyan)
                        .cornerRadius(4)
                })
            }
            .mapControls {
                MapUserLocationButton()
            }
            .onAppear {
                manager.requestWhenInUseAuthorization()
            }
            
            Button(action: {
                showingSheet.toggle()
            }, label: {
                Text("See Current Location Info")
            })
            .padding()
            .background(.white)
            .cornerRadius(10)
            .font(.title)
            .fontWeight(.semibold)
            .sheet(isPresented: $showingSheet, content: {
                LocationInfoView()
                    .presentationDetents([.fraction(0.3)])
            })
            
            
        }
        
    }
}

#Preview {
    ContentView()
}
