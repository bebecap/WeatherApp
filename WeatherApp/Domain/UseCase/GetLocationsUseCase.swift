//
//  GetLocationsUseCase.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 07.09.23.
//

import Factory
import Foundation

/// @mockable
protocol GetLocationsUseCase {
    func execute(query: String) async throws -> [Location]
}

final class GetLocationsUseCaseImpl: GetLocationsUseCase {
    @LazyInjected(\CoreContainer.weatherRepository) private var repository
    
    func execute(query: String) async throws -> [Location] {
        try await repository.getLocations(query: query)
    }
}
