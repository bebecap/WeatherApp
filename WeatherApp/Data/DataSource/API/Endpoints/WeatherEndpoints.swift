//
//  WeatherEndpoints.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 06.09.23.
//

import Foundation

enum WeatherEndpoints {
    case currentWeather(coordinate: Coordinate, units: Units)
    case geocoding(location: String)
}

extension WeatherEndpoints: Endpoint {
    var path: String {
        switch self {
        case .currentWeather:
            return "/data/2.5/weather"
        case .geocoding:
            return "/geo/1.0/direct"
        }
    }

    var method: RequestMethod {
        switch self {
        case .currentWeather, .geocoding:
            return .get
        }
    }

    var header: [String: String]? {
        switch self {
        case .currentWeather, .geocoding:
            return nil
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .currentWeather, .geocoding:
            return nil
        }
    }
    
    var query: [String: String]? {
        switch self {
        case .currentWeather(let coordinate, let units):
            return [
                "lat": String(coordinate.latitude),
                "lon": String(coordinate.longitude),
                "appId": GlobalConstants.weatherAPIKey,
                "units": units.rawValue
            ]
        case .geocoding(let location):
            return [
                "q": location,
                "appId": GlobalConstants.weatherAPIKey
            ]
        }
    }
}
