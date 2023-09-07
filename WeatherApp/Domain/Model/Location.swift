//
//  Location.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 07.09.23.
//

import Foundation

struct Location: Hashable {
    let name: String
    let coordinate: Coordinate
    let country: String
    let state: String?
    
    var userFriendlyText: String {
        var text = name
        if let state = state {
            text += ", \(state)"
        }
        text += ", \(country)"
        return text
    }
}

extension Location {
    init(entity: LocationEntity) {
        name = entity.name
        coordinate = .init(latitude: entity.latitude, longitude: entity.longitude)
        country = entity.country
        state = entity.state
    }
}

