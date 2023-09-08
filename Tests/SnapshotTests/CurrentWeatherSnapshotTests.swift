//
//  CurrentWeatherSnapshotTests.swift
//  WeatherAppTests
//
//  Created by Volodymyr Grytsenko on 06.09.23.
//

import Foundation
import SnapshotTesting
import SwiftUI
import XCTest

@testable import WeatherApp

final class CurrentWeatherSnapshotTest: WeatherSnapshotTestCase {
    func testCurrentWeather_withNoData() {
        snapshotTest(view: CurrentWeatherView(viewModel: .TestData.noData, selectedLocation: .constant(nil)))
    }
    
    func testCurrentWeather_withMunichMorning() {
        snapshotTest(view: CurrentWeatherView(viewModel: .TestData.munichMorning, selectedLocation: .constant(nil)))
    }
    
    func testCurrentWeather_withMunichNoon() {
        snapshotTest(view: CurrentWeatherView(viewModel: .TestData.munichNoon, selectedLocation: .constant(nil)))
    }
    
    func testCurrentWeather_withMunichEvening() {
        snapshotTest(view: CurrentWeatherView(viewModel: .TestData.munichEvening, selectedLocation: .constant(nil)))
    }
    
    func testCurrentWeather_withMunichEveningCloudy() {
        snapshotTest(view: CurrentWeatherView(viewModel: .TestData.munichEveningCloudy, selectedLocation: .constant(nil)))
    }
    
    func testCurrentWeather_withError() {
        snapshotTest(view: CurrentWeatherView(viewModel: .TestData.error, selectedLocation: .constant(nil)))
    }
}
