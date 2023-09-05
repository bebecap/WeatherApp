//
//  GetCurrentWeather.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 06.09.23.
//

import Factory
import Foundation

/// @mockable
protocol GetCurrentWeatherUseCase {
    func execute(coordinate: Coordinate, units: Units) async throws -> CurrentWeather
}

final class GetCurrentWeatherUseCaseImpl: GetCurrentWeatherUseCase {
    @LazyInjected(\CoreContainer.weatherRepository) private var repository
    
    func execute(coordinate: Coordinate, units: Units) async throws -> CurrentWeather {
        try await repository.getCurrentWeather(coordinate: coordinate, units: units)
    }
}
