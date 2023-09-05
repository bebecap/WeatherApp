//
//  CoreContainer+UseCases.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 06.09.23.
//

import Factory
import Foundation

extension CoreContainer {
    var getCurrentWeatherUseCase: Factory<GetCurrentWeatherUseCase> {
        self { GetCurrentWeatherUseCaseImpl() }
    }
}
