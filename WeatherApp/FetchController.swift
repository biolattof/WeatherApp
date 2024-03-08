//
//  FetchController.swift
//  WeatherApp
//
//  Created by Facundo Biolatto on 02/03/2024.
//

import Foundation
import SwiftUI

struct FetchController {
    enum NetworkError: Error {
        case badURL, badResponse, invalidImage
    }
    
    private var weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather")!
    
    func fetchWeather(from location: Location) async throws -> Weather {
        var queryComponents = URLComponents(url: weatherURL, resolvingAgainstBaseURL: true)
        queryComponents?.queryItems = []
        if let latitude = location.city.latitude, let longitude = location.city.longitude {
            let latitude = URLQueryItem(name: "lat", value: latitude.description)
            let longitude = URLQueryItem(name: "lon", value: longitude.description)
            queryComponents?.queryItems?.append(latitude)
            queryComponents?.queryItems?.append(longitude)
        } else {
            let name = URLQueryItem(name: "q", value: location.city.name)
            queryComponents?.queryItems?.append(name)
        }
        
        queryComponents?.queryItems?.append(URLQueryItem(name: "appid", value: String(Constants.weatherAPIKey)))
        queryComponents?.queryItems?.append(URLQueryItem(name: "units", value: "metric"))
        
        guard let fetchURL = queryComponents?.url else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        let weather = try JSONDecoder().decode(Weather.self, from: data)
        
        return weather
    }
    
    func downloadImage(from icon: String) async throws -> UIImage {
        let iconUrl = URL(string: "https://openweathermap.org/img/wn/\(icon)".formatAsIconURL)!
        
        let (data, response) = try await URLSession.shared.data(from: iconUrl)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        guard let image = UIImage(data: data) else {
            throw NetworkError.invalidImage
        }
        
        return image
    }
}


