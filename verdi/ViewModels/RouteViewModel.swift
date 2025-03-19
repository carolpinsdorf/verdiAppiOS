//
//  RouteViewModel.swift
//  verdi
//
//  Created by Carolina Pinsdorf on 18/03/25.
//

import Foundation

class RouteViewModel: ObservableObject {
    @Published var routes: [Route] = []
    @Published var currentOrigin: String = ""
    @Published var currentDestination: String = ""
    @Published var isLoading: Bool = false
    @Published var currentRouteDetails: RouteDetails?
    @Published var error: String?
    @Published var transportModes: [TransportMode] = []
    
    private let locationService = LocationService()
    private let userDefaults = UserDefaults.standard
    private let routesKey = "savedRoutes"
    
    init() {
        loadRoutes()
    }
    
    @MainActor
    func calculateRoute() async {
        isLoading = true
        error = nil
        
        do {
            currentRouteDetails = try await locationService.calculateRoute(
                origin: currentOrigin,
                destination: currentDestination
            )
            
            // Criar nova rota com os detalhes calculados
            let newRoute = Route(
                id: UUID(),
                origin: currentOrigin,
                destination: currentDestination,
                distance: currentRouteDetails?.distance,
                emission: nil, // Será preenchido depois com a Carbon Interface API
                date: Date()
            )
            
            saveRoute(newRoute)
            
            let carDuration = currentRouteDetails?.duration ?? 0
            self.transportModes = [
                TransportMode(type: .car, duration: formatDuration(carDuration), icon: TransportMode.getIcon(for: .car)),
                TransportMode(type: .bus, duration: formatDuration(carDuration * 1.5), icon: TransportMode.getIcon(for: .bus)),
                TransportMode(type: .train, duration: formatDuration(carDuration * 1.2), icon: TransportMode.getIcon(for: .train)),
                TransportMode(type: .bike, duration: formatDuration(carDuration * 3), icon: TransportMode.getIcon(for: .bike)),
                TransportMode(type: .walk, duration: formatDuration(carDuration * 12), icon: TransportMode.getIcon(for: .walk))
            ]
            
        } catch {
            self.error = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func loadRoutes() {
        if let data = userDefaults.data(forKey: routesKey),
           let decodedRoutes = try? JSONDecoder().decode([Route].self, from: data) {
            routes = decodedRoutes
        }
    }
    
    func saveRoute(_ route: Route) {
        routes.append(route)
        if let encodedRoutes = try? JSONEncoder().encode(routes) {
            userDefaults.set(encodedRoutes, forKey: routesKey)
        }
    }
    
    private func formatDuration(_ seconds: Double) -> String {
        let hours = Int(seconds) / 3600
        let minutes = Int(seconds) / 60 % 60
        
        if hours > 0 {
            return "\(hours)h \(minutes)min"
        } else {
            return "\(minutes)min"
        }
    }
} 
