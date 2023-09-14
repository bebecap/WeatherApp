//
//  WindInformationEntity+TestData.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 08.09.23.
//

import Foundation

extension WindInformationEntity {
    enum TestData {
        static let `default` = WindInformationEntity(
            speed: 15,
            directionDegrees: 45,
            gustSpeed: nil
        )
    }
}
