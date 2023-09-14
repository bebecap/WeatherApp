//
//  FlipCardSnapshotTests.swift
//  WeatherAppTests
//
//  Created by Volodymyr Grytsenko on 07.09.23.
//

import Foundation
import SnapshotTesting
import SwiftUI
import XCTest

@testable import WeatherApp

final class FlipCardSnapshotTests: WeatherSnapshotTestCase {
    func testFlipCard_withNoData() {
        snapshotTest(view: FlipCardView(currentWeatherViewModel: .TestData.noData, locationSearchViewModel: .TestData.empty))
    }
    
    func testCurrentWeather_munichMorning() {
        snapshotTest(view: FlipCardView(currentWeatherViewModel: .TestData.munichMorning, locationSearchViewModel: .TestData.empty))
    }
    
    func testCurrentWeather_munichNoon() {
        snapshotTest(view: FlipCardView(currentWeatherViewModel: .TestData.munichNoon, locationSearchViewModel: .TestData.empty))
    }
    
    func testCurrentWeather_munichEvening() {
        snapshotTest(view: FlipCardView(currentWeatherViewModel: .TestData.munichEvening, locationSearchViewModel: .TestData.empty))
    }
    
    func testCurrentWeather_munichEveningCloudy() {
        snapshotTest(view: FlipCardView(currentWeatherViewModel: .TestData.munichEveningCloudy, locationSearchViewModel: .TestData.empty))
    }
}
