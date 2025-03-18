//
//  LocationService.swift
//  verdi
//
//  Created by Carolina Pinsdorf on 18/03/25.
//

import Foundation
import CoreLocation

class LocationService: ObservableObject {
    private let apiKey: String = "SUA_CHAVE_API_AQUI" // Substitua com sua chave da API Google Maps
    
    func calculateRoute(origin: String, destination: String) async throws -> RouteDetails {
        // Construir a URL da API do Google Maps Directions
        let baseURL = "https://maps.googleapis.com/maps/api/directions/json"
        let encodedOrigin = origin.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let encodedDestination = destination.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        guard let url = URL(string: "\(baseURL)?origin=\(encodedOrigin)&destination=\(encodedDestination)&key=\(apiKey)") else {
            throw LocationError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw LocationError.invalidResponse
        }
        
        let routeResponse = try JSONDecoder().decode(DirectionsResponse.self, from: data)
        
        guard let route = routeResponse.routes.first,
              let leg = route.legs.first else {
            throw LocationError.noRouteFound
        }
        
        return RouteDetails(
            distance: leg.distance.value,
            duration: leg.duration.value,
            polyline: route.overviewPolyline.points
        )
    }
}

