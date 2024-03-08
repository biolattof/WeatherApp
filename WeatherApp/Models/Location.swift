//
//  Location.swift
//  WeatherApp
//
//  Created by Facundo Biolatto on 02/03/2024.
//

import Foundation

class Location: Codable, Identifiable, ObservableObject {
    var id = UUID()
    var city: City
    
    init(city: City) {
        self.city = city
    }
    
    required init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        city = try container.decode(City.self)
    }
}
