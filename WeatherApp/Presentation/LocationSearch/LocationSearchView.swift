//
//  LocationSearchView.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 07.09.23.
//

import Foundation
import SwiftUI

struct LocationSearchView: View {
    @StateObject var viewModel: LocationSearchViewModel

    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter location", text: $viewModel.query)
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)

            List(viewModel.locations, id: \.self) { location in
                Text(location.userFriendlyText)
                    .onTapGesture {
                        viewModel.selectedLocation = location
                    }
            }

            Spacer()
        }
        .navigationBarTitle("Search Location")
    }
}
