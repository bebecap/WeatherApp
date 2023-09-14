//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 05.09.23.
//

import SwiftUI

struct CurrentWeatherView: View {
    @StateObject var viewModel: CurrentWeatherViewModel
    @Binding var selectedLocation: Location?

    var isUnitTesting: Bool {
        ProcessInfo.processInfo.environment["IS_UNIT_TESTING"] == "true"
    }
    
    var body: some View {
        ZStack {
            if let errorText = viewModel.errorText {
                VStack {
                    Text(errorText)
                    Button {
                        Task {
                            await viewModel.retry()
                        }
                    } label: {
                        Text("Retry request")
                    }
                }
            } else {
                WeatherBackgroundView(sunPosition: $viewModel.sunPosition, cloudsOpacity: $viewModel.cloudsOpacity)
                DegreeView(
                    degrees: $viewModel.temperature,
                    location: $viewModel.city,
                    minTemparature: $viewModel.minTemperature,
                    maxTemperature: $viewModel.maxTemperature,
                    status: $viewModel.status
                )
                .padding()
            }
        }
        .onChange(of: selectedLocation) { newValue in
            Task {
                try await viewModel.updateSelectedLocation(newValue)
            }
        }
        .onAppear {
            guard !isUnitTesting else { return }

            viewModel.onAppear()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView(viewModel: CurrentWeatherViewModel.TestData.munichMorning, selectedLocation: .constant(nil))
    }
}
