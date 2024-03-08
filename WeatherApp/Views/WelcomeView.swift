//
//  WelcomeView.swift
//  WeatherApp
//
//  Created by Facundo Biolatto on 06/03/2024.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                Text("Welcome to the Weather app")
                    .font(.title)
                    .bold()
                
                Text("Please share your current location to get the weather in your area")
                    .font(.subheadline)
                    .bold()
            }
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .padding(32)
            
            Button {
                locationManager.requestLocation()
            } label: {
                HStack(spacing: 20) {
                    Image(systemName: "location.fill")
                    
                    Text("Share Current Location")
                }
            }
            .font(.title2)
            .foregroundColor(.white)
            .padding(10)
            .background(Color.black)
            .cornerRadius(32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

#Preview {
    WelcomeView()
}
