//
//  CoreContainer+Repositories.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 06.09.23.
//

import Factory
import Foundation

extension CoreContainer {
    var weatherRepository: Factory<WeatherRepository> {
        self { WeatherRepositoryImpl() }
    }
}
