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
