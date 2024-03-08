//
//  City.swift
//  WeatherApp
//
//  Created by Facundo Biolatto on 04/03/2024.
//

import Foundation
import CoreLocation

struct City: Codable {
    var name: String?
    var latitude: CGFloat?
    var longitude: CGFloat?
    
    init(name: String? = nil, latitude: CGFloat? = nil, longitude: CGFloat? = nil) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.name = nil
        self.latitude = CGFloat(latitude)
        self.longitude = CGFloat(longitude)
    }
    
    enum CityKeys: String, CodingKey {
        case name
        case latitude = "lat"
        case longitude = "lon"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CityKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        latitude = try container.decode(CGFloat.self, forKey: .latitude)
        longitude = try container.decode(CGFloat.self, forKey: .longitude)
    }
}
