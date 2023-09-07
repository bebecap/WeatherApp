//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 05.09.23.
//

import Foundation

struct CurrentWeather: Hashable {
    let temperature: Double
    let minTemperature: Double
    let maxTemperature: Double
    let status: String?
    let city: String?
    let sunset: Date
    let sunrise: Date
    let clouds: Int
}

extension CurrentWeather {
    init(entity: CurrentWeatherEntity) {
        temperature = entity.mainWeather.temperature
        minTemperature = entity.mainWeather.minimumTemperature
        maxTemperature = entity.mainWeather.maximumTemperature
        status = entity.weatherConditions.first?.group
        city = entity.cityName
        sunset = Date(timeIntervalSince1970: TimeInterval(entity.system.sunsetTime))
        sunrise = Date(timeIntervalSince1970: TimeInterval(entity.system.sunriseTime))
        clouds = entity.cloudCoverage.coveragePercentage
    }
}
