//
//  CurrentWeatherEntity+TestData.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 08.09.23.
//

import Foundation

extension CurrentWeatherEntity {
    enum TestData {
        static let `default` = CurrentWeatherEntity(
            coordinates: .TestData.default,
            weatherConditions: [],
            base: "",
            mainWeather: .TestData.default,
            visibility: 100,
            wind: .TestData.default,
            rain: nil,
            snow: nil,
            cloudCoverage: .TestData.default,
            dataTime: 1694124732,
            system: .TestData.default,
            timezoneOffset: 0,
            cityId: 5,
            cityName: "Munich",
            code: 33
        )
    }
}
