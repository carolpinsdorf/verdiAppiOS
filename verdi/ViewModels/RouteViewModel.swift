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
    private let carbonService = CarbonService()
    
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
            
            let carDuration = currentRouteDetails?.duration ?? 0
            let distanceKm = (currentRouteDetails?.distance ?? 0) / 1000.0
            
            // Debug: Imprimir a distância que será enviada
            print("Distância em km para cálculo de emissões:", distanceKm)
            
            // Calcular emissões de carbono para carro
            let carEmissions = try await carbonService.calculateEmissions(distanceKm: distanceKm)
            
            // Debug: Imprimir as emissões calculadas
            print("Emissões calculadas para carro:", carEmissions)
            
            self.transportModes = [
                TransportMode(type: .car, duration: formatDuration(carDuration), icon: TransportMode.getIcon(for: .car), carbonKg: carEmissions),
                TransportMode(type: .bus, duration: formatDuration(carDuration * 1.5), icon: TransportMode.getIcon(for: .bus), carbonKg: carEmissions * 0.3),
                TransportMode(type: .train, duration: formatDuration(carDuration * 1.2), icon: TransportMode.getIcon(for: .train), carbonKg: carEmissions * 0.1),
                TransportMode(type: .bike, duration: formatDuration(carDuration * 3), icon: TransportMode.getIcon(for: .bike), carbonKg: 0),
                TransportMode(type: .walk, duration: formatDuration(carDuration * 12), icon: TransportMode.getIcon(for: .walk), carbonKg: 0)
            ]
            
            // Debug: Imprimir os modos de transporte atualizados
            print("Transport Modes atualizados:", self.transportModes.map { "\($0.type): \($0.carbonKg ?? 0) kg" })
            
            // Criar nova rota com os detalhes calculados
            let newRoute = Route(
                id: UUID(),
                origin: currentOrigin,
                destination: currentDestination,
                distance: currentRouteDetails?.distance,
                emission: carEmissions,
                date: Date()
            )
            
            saveRoute(newRoute)
            
        } catch {
            self.error = error.localizedDescription
            // Debug: Imprimir o erro
            print("Erro ao calcular rota:", error)
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
