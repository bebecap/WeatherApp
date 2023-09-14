//
//  MainWeatherEntity+TestData.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 08.09.23.
//

import Foundation

extension MainWeatherEntity {
    enum TestData {
        static let `default` = MainWeatherEntity(
            temperature: 20,
            feelsLikeTemperature: 20,
            minimumTemperature: 15,
            maximumTemperature: 25,
            atmosphericPressure: 750,
            humidityPercentage: 20,
            seaLevelPressure: nil,
            groundLevelPressure: nil
        )
    }
}
