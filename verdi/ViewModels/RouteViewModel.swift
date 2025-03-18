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
} 
