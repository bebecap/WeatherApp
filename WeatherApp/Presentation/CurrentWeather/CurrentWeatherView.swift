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

    var body: some View {
        ZStack {
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
        .onChange(of: selectedLocation) { newValue in
            viewModel.selectedLocation = newValue
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView(viewModel: CurrentWeatherViewModel.TestData.munichMorning, selectedLocation: .constant(nil))
    }
}
