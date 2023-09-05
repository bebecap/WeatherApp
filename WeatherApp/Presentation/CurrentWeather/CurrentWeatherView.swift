//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 05.09.23.
//

import SwiftUI

struct CurrentWeatherView: View {
    @StateObject var viewModel: CurrentWeatherViewModel

    var body: some View {
        VStack {
            Text(viewModel.city ?? "")
                .font(.title)
            Text("\(viewModel.temperature?.formatted() ?? "NaN")°" )
                .font(.title2)
        }
        .padding()
        .onAppear {
            viewModel.onAppear()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView(viewModel: CurrentWeatherViewModel.mock)
    }
}
