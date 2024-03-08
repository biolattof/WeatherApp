//
//  SelectLocationView.swift
//  WeatherApp
//
//  Created by Facundo Biolatto on 07/03/2024.
//

import SwiftUI

struct SelectLocationView: View {
    var locations: [Location]
    @Binding var selectedLocation: Location?
    @Binding var showSelectLocation: Bool
    
    var body: some View {
        List {
            ForEach(locations) { location in
                Button(action: {
                    selectedLocation = location
                    showSelectLocation = false
                }) {
                    LocationRow(location: location, selected: selectedLocation?.id == location.id)
                }
            }
        }
        .listStyle(.inset)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .preferredColorScheme(.dark)
        .onAppear {
            UITableViewCell.appearance().selectionStyle = .none
            UITableView.appearance().isUserInteractionEnabled = false
        }
    }
}

#Preview {
    SelectLocationView(locations: Constants.locations, selectedLocation: .constant(Constants.locations.first!), showSelectLocation: .constant(true))
}
