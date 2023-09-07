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
            locationTextField
            
            currentLocationButton
            
            if let errorText = viewModel.errorText {
                Text(errorText)
                Button {
                    viewModel.retry()
                } label: {
                    Text("Retry request")
                }
            } else {
                if viewModel.locations.isEmpty {
                    Text("No results")
                } else {
                    locationsList
                }
            }
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private var locationTextField: some View {
        TextField("Enter location", text: $viewModel.query)
            .padding(10)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .padding(.horizontal)
    }
    
    private var currentLocationButton: some View {
        Button(action: {
            viewModel.selectedLocation = nil
            viewModel.clear()
            viewModel.shouldCloseSubject.send()
        }) {
            HStack {
                Image(systemName: "location.circle.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                Text("Use Current Location")
            }
            .foregroundColor(.blue)
        }
        .padding(.horizontal)
    }
    
    private var locationsList: some View {
        List(viewModel.locations, id: \.self) { location in
            Button(action: {
                viewModel.selectedLocation = location
                viewModel.clear()
                viewModel.shouldCloseSubject.send()
            }) {
                Text(location.userFriendlyText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
