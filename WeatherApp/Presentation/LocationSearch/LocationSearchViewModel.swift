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
    @Published var errorText: String? = nil
    
    var shouldCloseSubject = PassthroughSubject<Void, Never>()

    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        $query
            .dropFirst()
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .removeDuplicates()
            .compactMap { $0 }
            .sink { [weak self] query in
                if query == "" {
                    self?.locations = []
                } else {
                    self?.getNewLocations(query: query)
                }
            }.store(in: &cancellables)
    }
    
    func retry() {
        getNewLocations(query: query)
    }
    
    func clear() {
        query = ""
        locations = []
        errorText = nil
    }
    
    private func getNewLocations(query: String) {
        Task {
            do {
                await updateError(error: nil)
                let fetchedLocations = try await getLocationsUseCase.execute(query: query)
                await updateLocations(fetchedLocations)
            } catch {
                await updateError(error: error)
            }
        }
    }
    
    @MainActor
    private func updateLocations(_ newLocations: [Location]) {
        self.locations = newLocations
    }
    
    @MainActor
    private func updateError(error: Error?) {
        self.errorText = error?.localizedDescription
    }
}
