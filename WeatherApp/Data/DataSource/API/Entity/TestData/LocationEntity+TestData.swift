//
//  LocationEntity+TestData.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 08.09.23.
//

import Foundation

extension LocationEntity {
    enum TestData {
        static let `default` = LocationEntity(
            name: "Munich",
            localNames: [:],
            latitude: 0,
            longitude: 0,
            country: "Germany",
            state: "Bayern"
        )
    }
}
