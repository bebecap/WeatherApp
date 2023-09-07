//
//  LocationSearchViewModel.swift
//  WeatherApp
//
//  Created by Volodymyr Grytsenko on 07.09.23.
//

import Combine
import Factory
import Foundation

final class LocationSearchViewModel: ObservableObject {
    @LazyInjected(\CoreContainer.getLocationsUseCase) private var getLocationsUseCase
    @Published var query: String = ""
    @Published var locations: [Location] = []
    @Published var selectedLocation: Location?
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        $query
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .removeDuplicates()
            .compactMap { $0 }
            .sink { [weak self] query in
                Task { [weak self] in
                    let fetchedLocations = try await self?.getLocationsUseCase.execute(query: query) ?? []
                    await self?.updateLocations(fetchedLocations)
                }
            }.store(in: &cancellables)
    }
    
    @MainActor
    private func updateLocations(_ newLocations: [Location]) {
        self.locations = newLocations
    }
}
