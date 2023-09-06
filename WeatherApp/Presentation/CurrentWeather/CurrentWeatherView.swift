//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 05.09.23.
//

import SwiftUI

struct CurrentWeatherView: View {
    @StateObject var viewModel: CurrentWeatherViewModel
    @State var sunPosition: Double?

    var body: some View {
        ZStack {
            SunPathView(sunPosition: $sunPosition)
            DegreeView(degrees: $viewModel.temperature, location: $viewModel.city)
            .padding()
        }
        .onReceive(viewModel.$sunPosition) { newPosition in
            withAnimation(.linear(duration: 0.5)) {
                self.sunPosition = newPosition
            }
        }
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
