//
//  WeatherAPIImpl.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 05.09.23.
//

import Foundation

final class WeatherAPIImpl: HTTPClient, WeatherDataSource {
    func getCurrentWeather(coordinate: Coordinate, units: Units) async throws -> CurrentWeather {
        let result = await sendRequest(endpoint: WeatherEndpoints.currentWeather(coordinate: coordinate, units: units), responseModel: CurrentWeatherEntity.self)
        switch result {
        case .success(let entity):
            return CurrentWeather(entity: entity)
        case .failure(let error): throw error
        }
    }
    
    func getLocations(query: String) async throws -> [Location] {
        let result = await sendRequest(endpoint: WeatherEndpoints.geocoding(location: query), responseModel: [LocationEntity].self)
        switch result {
        case .success(let locations):
            return locations.map { Location(entity: $0) }
        case .failure(let error): throw error
        }
    }
}
