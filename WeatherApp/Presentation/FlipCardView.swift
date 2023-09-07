//
//  FlipCardView.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 07.09.23.
//

import Foundation
import SwiftUI

struct FlipCardView: View {
    @State private var isFlipped: Bool = false
    @StateObject var currentWeatherViewModel: CurrentWeatherViewModel
    @StateObject var locationSearchViewModel: LocationSearchViewModel

    var body: some View {
        ZStack {
            ZStack {
                CurrentWeatherView(viewModel: currentWeatherViewModel, selectedLocation: $locationSearchViewModel.selectedLocation)

                VStack {
                    HStack {
                        Spacer()
                        
                        Image(systemName: "magnifyingglass")
                            .padding()
                            .background(Color.white.opacity(0.7))
                            .clipShape(Circle())
                            .onTapGesture {
                                withAnimation {
                                    isFlipped.toggle()
                                }
                            }
                    }
                    Spacer()
                }
                .padding()
            }
            .opacity(isFlipped ? 0 : 1)
            .rotation3DEffect(
                .degrees(isFlipped ? -180 : 0),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            
            LocationSearchView(viewModel: locationSearchViewModel)
                .opacity(isFlipped ? 1 : 0)
                .rotation3DEffect(
                    .degrees(isFlipped ? 0 : 180),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
        }
        .onChange(of: locationSearchViewModel.selectedLocation) { selectedLocation in
            guard selectedLocation != nil else { return }
            withAnimation {
                isFlipped.toggle()
            }
        }
    }
}
