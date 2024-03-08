//
//  ContentView.swift
//  WeatherApp
//
//  Created by Facundo Biolatto on 02/03/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            if locationManager.location != nil {
                WeatherView(locationManager: locationManager)
            } else if locationManager.isLoading {
                LoadingView()
            } else {
                WelcomeView()
                    .environmentObject(locationManager)
            }
        }
    }
}

#Preview {
    ContentView()
}
