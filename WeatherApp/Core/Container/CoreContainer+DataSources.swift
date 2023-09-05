//
//  CoreContainer+DataSources.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 06.09.23.
//

import Factory
import Foundation

extension CoreContainer {
    var api: Factory<WeatherAPIImpl> {
        self { WeatherAPIImpl() }
    }
    
    var weatherDataSource: Factory<WeatherDataSource> {
        self { self.api() }
    }
}
