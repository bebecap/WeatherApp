//
//  Location+TestData.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 07.09.23.
//

import Foundation

extension Location {
    enum TestData {
        static let `default` = Location(name: "Munich", coordinate: .init(latitude: 0, longitude: 0), country: "Germany", state: "Bayern")
    }
}
