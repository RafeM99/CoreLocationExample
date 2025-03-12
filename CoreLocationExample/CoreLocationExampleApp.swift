//
//  CoreLocationExampleApp.swift
//  CoreLocationExample
//
//  Created by Rafe Marriott on 10/03/2025.
//

import SwiftUI

@main
struct CoreLocationExampleApp: App {
    @State private var locationManger = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            if locationManger.isAuthorised {
                ContentView()
            } else {
                Text("Need to help user")
            }
            
        }
        .environment(locationManger)
    }
}
