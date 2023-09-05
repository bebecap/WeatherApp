//
//  WeatherDataSource.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 05.09.23.
//

import Foundation

/// @mockable
protocol WeatherDataSource {
    func getCurrentWeather(coordinate: Coordinate, units: Units) async throws -> CurrentWeather
}
