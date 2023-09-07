//
//  SystemInformationEntity+TestData.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 08.09.23.
//

import Foundation

extension SystemInformationEntity {
    enum TestData {
        static let `default` = SystemInformationEntity(
            id: 5,
            type: 3,
            country: "Germany",
            sunriseTime: 1694067069,
            sunsetTime: 1694110269
        )
    }
}
