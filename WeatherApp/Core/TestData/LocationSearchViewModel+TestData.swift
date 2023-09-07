//
//  LocationSearchViewModel+TestData.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 07.09.23.
//

import Foundation

extension LocationSearchViewModel {
    enum TestData {
        static var empty: LocationSearchViewModel {
            let viewModel = LocationSearchViewModel()
            viewModel.query = ""
            viewModel.locations = []
            viewModel.errorText = nil
            return viewModel
        }
        
        static var withError: LocationSearchViewModel {
            let viewModel = LocationSearchViewModel()
            viewModel.query = ""
            viewModel.locations = []
            viewModel.errorText = "Test Error"
            return viewModel
        }
        
        static var withQuery: LocationSearchViewModel {
            let viewModel = LocationSearchViewModel()
            viewModel.query = "Munich"
            viewModel.locations = []
            viewModel.errorText = nil
            return viewModel
        }
        
        static var withLocation: LocationSearchViewModel {
            let viewModel = LocationSearchViewModel()
            viewModel.query = "Munich"
            viewModel.locations = [.TestData.default]
            viewModel.errorText = nil
            return viewModel
        }
    }
}
