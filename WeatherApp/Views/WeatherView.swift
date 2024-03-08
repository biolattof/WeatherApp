//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Facundo Biolatto on 06/03/2024.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewmodel: WeatherViewModel
    @State var showSelectLocation = false
    
    init(locationManager: LocationManager) {
        _viewmodel = StateObject(wrappedValue: WeatherViewModel(controller: FetchController(), locationManager: locationManager))
    }
    
    var body: some View {
        switch viewmodel.status {
        case .success(let weather, let weatherIcon):
            ZStack {
                //background
                Image("daylightsky")
                    .scaledToFit()
                
                VStack(spacing: 5) {
                    Text((weather.location?.city.name?.uppercased())!)
                        .font(.system(size: 32, weight: .light))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2)
                        .padding(.horizontal, 120)
                    
                    Text(weather.temp.toStringInDegreesCelsius)
                        .font(.system(size: 112, weight: .light))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2)
                        .offset(x: 20)
                    
                    Text(weather.description.capitalized)
                        .font(.system(size: 24, weight: .light))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2)
                    
                    HStack {
                        Text(String(weather.tempMax.toStringInDegreesCelsius.addHighTempraturePrefix))
                            .font(.system(size: 24, weight: .light))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                        
                        Text(String(weather.tempMin.toStringInDegreesCelsius.addLowTempraturePrefix))
                            .font(.system(size: 24, weight: .light))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                    }
                                        
                    VStack(spacing: 5) {
                        Image(uiImage: weatherIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .shadow(color: .black, radius: 2)
                        
                        Text("Today, \(viewmodel.getDate())")
                            .font(.system(size: 24, weight: .light))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                    }
                    .padding(.horizontal, 80)
                }
                .onTapGesture {
                    showSelectLocation.toggle()
                }
            }
            .sheet(isPresented: $showSelectLocation) {
                SelectLocationView(locations: viewmodel.locations, selectedLocation: $viewmodel.selectedLocation, showSelectLocation: $showSelectLocation)
            }
        default:
            LoadingView()
        }
    }
}

#Preview {
    WeatherView(locationManager: LocationManager())
}
