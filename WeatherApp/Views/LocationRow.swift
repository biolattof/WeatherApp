//
//  LocationRow.swift
//  WeatherApp
//
//  Created by Facundo Biolatto on 04/03/2024.
//

import SwiftUI

struct LocationRow: View {
    var location: Location
    var selected: Bool
    
    var body: some View {
        HStack(spacing: -2) {
            if selected {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.white)
            }
            
            Text(location.city.name?.capitalized ?? "")
                .font(.system(size: 20))
                .minimumScaleFactor(0.5)
                .foregroundColor(.white)
                .padding(.horizontal, 10)
                
            Spacer()
        }
        .frame(width: 300, height: 50)
        .shadow(color: .white, radius: 1)
    }
}

#Preview {
    LocationRow(location: Location(city: City(name: "Montevideo")), selected: true)
        .preferredColorScheme(.dark)
}
