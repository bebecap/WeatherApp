//
//  LocationSearchViewSnapshotTests.swift
//  WeatherAppTests
//
//  Created by Volodymyr Grytsenko on 07.09.23.
//

import Foundation
import SnapshotTesting
import SwiftUI
import XCTest

@testable import WeatherApp

final class LocationSearchViewSnapshotTests: WeatherSnapshotTestCase {
    func testLocationSearchView_withNoData() {
        snapshotTest(view: LocationSearchView(viewModel: .TestData.empty))
    }
    
    func testLocationSearchView_withError() {
        snapshotTest(view: LocationSearchView(viewModel: .TestData.withError))
    }
    
    func testLocationSearchView_withQuery() {
        snapshotTest(view: LocationSearchView(viewModel: .TestData.withQuery))
    }
    
    func testLocationSearchView_withLocation() {
        snapshotTest(view: LocationSearchView(viewModel: .TestData.withLocation))
    }
}
