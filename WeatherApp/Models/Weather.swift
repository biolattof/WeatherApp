//
//  Weather.swift
//  WeatherApp
//
//  Created by Facundo Biolatto on 02/03/2024.
//

import Foundation

struct Weather: Decodable {
    var location: Location?
    var main = ""
    var description = ""
    var icon = ""
    var temp: CGFloat = 0.0
    var tempMin: CGFloat = 0.0
    var tempMax: CGFloat = 0.0
    
    enum WeatherKeys: String, CodingKey {
        case coord
        case weather
        case main
        case name
        
        enum CoordDictionaryKeys: String, CodingKey {
            case latitude = "lat"
            case longitude = "lon"
        }
        
        enum WeatherDictionaryKeys: String, CodingKey {
            case main
            case description
            case icon
        }
        
        enum MainDictionaryKeys: String, CodingKey {
            case temp
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: WeatherKeys.self)
        
        var city = City()
        city.name = try container.decode(String.self, forKey: .name)
        //Coord
        let coordContainer = try container.nestedContainer(keyedBy: WeatherKeys.CoordDictionaryKeys.self, forKey: .coord)
        city.latitude = try coordContainer.decode(CGFloat.self, forKey: .latitude)
        city.longitude = try coordContainer.decode(CGFloat.self, forKey: .longitude)
        location = Location(city: city)
        
        //Weather
        var weatherContainer = try container.nestedUnkeyedContainer(forKey: .weather)
        while !weatherContainer.isAtEnd {
            let weatherDictionaryContainer = try weatherContainer.nestedContainer(keyedBy: WeatherKeys.WeatherDictionaryKeys.self)
            main = try weatherDictionaryContainer.decode(String.self, forKey: .main)
            description = try weatherDictionaryContainer.decode(String.self, forKey: .description)
            icon = try weatherDictionaryContainer.decode(String.self, forKey: .icon)
        }
        
        //Main
        let mainContainer = try container.nestedContainer(keyedBy: WeatherKeys.MainDictionaryKeys.self, forKey: .main)
        temp = try mainContainer.decode(CGFloat.self, forKey: .temp)
        tempMin = try mainContainer.decode(CGFloat.self, forKey: .tempMin)
        tempMax = try mainContainer.decode(CGFloat.self, forKey: .tempMax)
    }
}
