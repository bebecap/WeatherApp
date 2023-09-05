//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 06.09.23.
//

import Foundation

/// @mockable
protocol WeatherRepository {
    func getCurrentWeather(coordinate: Coordinate, units: Units) async throws -> CurrentWeather
}
