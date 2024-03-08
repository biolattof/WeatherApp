//
//  Constants.swift
//  WeatherApp
//
//  Created by Facundo Biolatto on 02/03/2024.
//

import Foundation
import SwiftUI

enum Constants {
    static let weatherAPIKey = "dcce993f819be304e47bf34a1a9a145d"
    static let locations: [Location] = [Location(city: City(name: "London")),
                            Location(city: City(name: "Montevideo")),
                            Location(city: City(name: "Buenos Aires"))]
}

extension CGFloat {
    var toStringInDegreesCelsius: String {
        String(format: "%.0f", self).appending("°")
    }
}

extension String {
    var addHighTempraturePrefix: String {
        "H:" + self
    }
    
    var addLowTempraturePrefix: String {
        "L:" + self
    }
    
    var formatAsIconURL: String {
        self + "@2x.png"
    }
    
    func appendPath(_ path: String) -> String {
        self + path
    }
}
