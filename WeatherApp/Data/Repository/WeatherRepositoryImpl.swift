//
//  WeatherRepositoryImpl.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 06.09.23.
//

import Factory
import Foundation

final class WeatherRepositoryImpl: WeatherRepository {
    @LazyInjected(\CoreContainer.weatherDataSource) private var dataSource
    
    func getCurrentWeather(coordinate: Coordinate, units: Units) async throws -> CurrentWeather {
        try await dataSource.getCurrentWeather(coordinate: coordinate, units: units)
    }
    
    func getLocations(query: String) async throws -> [Location] {
        try await dataSource.getLocations(query: query)
    }
}
