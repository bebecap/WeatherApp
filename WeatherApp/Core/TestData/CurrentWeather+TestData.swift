//
//  CurrentWeather+TestData.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 08.09.23.
//

import Foundation

extension CurrentWeather {
    enum TestData {
        static let `default` = CurrentWeather(
            temperature: 20,
            minTemperature: 16,
            maxTemperature: 26,
            status: "Cloudy",
            city: "Munich",
            sunset: Date(timeIntervalSince1970: 1694110269),
            sunrise: Date(timeIntervalSince1970: 1694067069),
            clouds: 60
        )
    }
}
