//
//  LocationService.swift
//  verdi
//
//  Created by Carolina Pinsdorf on 18/03/25.
//

import Foundation
import CoreLocation

class LocationService: ObservableObject {
    private let apiKey: String = "CHAVE_DA_API" // Substitua com a chave da API Google Maps
    
    func calculateRoute(origin: String, destination: String) async throws -> RouteDetails {
        // Construir a URL da API do Google Maps Directions
        let baseURL = "https://maps.googleapis.com/maps/api/directions/json"
        let encodedOrigin = origin.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let encodedDestination = destination.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let urlString = "\(baseURL)?origin=\(encodedOrigin)&destination=\(encodedDestination)&key=\(apiKey)"
        print("URL da requisição: \(urlString)") // Debug
        
        guard let url = URL(string: urlString) else {
            throw LocationError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw LocationError.invalidResponse
            }
            
            print("Status code: \(httpResponse.statusCode)") // Debug
            
            if httpResponse.statusCode != 200 {
                // Tentar decodificar a mensagem de erro da Google
                if let errorJson = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let status = errorJson["status"] as? String,
                   let errorMessage = errorJson["error_message"] as? String {
                    print("Erro da API: \(status) - \(errorMessage)") // Debug
                    throw LocationError.apiError(message: errorMessage)
                }
                throw LocationError.invalidResponse
            }
            
            // Debug: imprimir a resposta JSON
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Resposta da API: \(jsonString)")
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
        } catch {
            print("Erro na requisição: \(error.localizedDescription)") // Debug
            throw error
        }
    }
}

