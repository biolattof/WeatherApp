//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Facundo Biolatto on 02/03/2024.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class WeatherViewModel: ObservableObject {
    enum Status {
        case notStarted
        case fetching
        case success(weather: Weather, iconImage: UIImage)
        case failed(error: Error)
    }
    
    @Published private(set) var status = Status.notStarted
    @Published private(set) var locations: [Location] = Constants.locations
    @Published var selectedLocation: Location?
    private var cancellable: AnyCancellable?
    private let controller: FetchController
    @AppStorage("SelectedLocation") private var selectedLocationData: Data?
    
    init(controller: FetchController, locationManager: LocationManager) {
        self.controller = controller
        
        //Saves current location into Locations array
        if let location = locationManager.location {
            locations.append(Location(city: City(latitude: location.latitude, longitude: location.longitude)))
        }
        
        cancellable = $selectedLocation
            .sink { newSelectedLocation in
                Task {
                    guard let newSelectedLocation = newSelectedLocation else {
                        return
                    }
                    await self.fillCurrentLocationNameIfNecessary()
                    await self.getWeather(location: newSelectedLocation)
                    self.saveSelectedLocation()
                }
            }
        
        //Retrieves previous selected location
        if let locationData = selectedLocationData {
            let selectedIndex = try? JSONDecoder().decode(Int.self, from: locationData)
            selectedLocation = locations[selectedIndex ?? 0]
        } else  {
            selectedLocation = locations.last
        }
    }
    
    func getWeather(location: Location) async {
        status = .fetching
        do {
            let weather = try await controller.fetchWeather(from: location)
            let iconImage = try await downloadWeatherIcon(icon: weather.icon)
            status = .success(weather: weather, iconImage: iconImage)
        } catch {
            status = .failed(error: error)
        }
    }
    
    func fillCurrentLocationNameIfNecessary() async {
        guard let location = locations.last else {
            return
        }
        do {
            let weather = try await controller.fetchWeather(from: location)
            location.city.name = weather.location?.city.name
        } catch {
            status = .failed(error: error)
        }
    }
    
    func downloadWeatherIcon(icon: String) async throws -> UIImage {
        return try await controller.downloadImage(from: icon)
    }
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter.string(from: Date())
    }
    
    func saveSelectedLocation() {
        guard let selectedLocation = selectedLocation else {
            return
        }
        let index = locations.firstIndex(where: { $0.id == selectedLocation.id })
        let locationData = try? JSONEncoder().encode(index)
        selectedLocationData = locationData
    }
}
