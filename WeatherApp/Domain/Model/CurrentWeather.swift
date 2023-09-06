//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 05.09.23.
//

import Foundation

struct CurrentWeather: Hashable {
    let temperature: Double
    let feelsLikeTemperature: Double
    let minimumTemperature: Double
    let maximumTemperature: Double
    let atmosphericPressure: Int
    let humidityPercentage: Int
    let seaLevelPressure: Int?
    let groundLevelPressure: Int?
    let city: String?
    let sunset: Date
    let sunrise: Date
}
