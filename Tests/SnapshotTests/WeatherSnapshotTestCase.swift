//
//  WeatherSnapshotTestCase.swift
//  SnapshotTests
//
//  Created by Volodymyr Grytsenko on 08.09.23.
//

import Foundation
import SnapshotTesting
import SwiftUI
import XCTest

class WeatherSnapshotTestCase: WeatherTestCase {
    func snapshotTest(view: some View, testName: String = #function, file: StaticString = #file) {
        let hostingController = UIHostingController(rootView: view)
        hostingController.view.frame = UIScreen.main.bounds
        assertSnapshot(of: hostingController.view, as: .image, file: file, testName: testName)
    }
}
