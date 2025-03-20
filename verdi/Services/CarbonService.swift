//
//  CarbonService.swift
//  verdi
//
//  Created by Carolina Pinsdorf on 18/03/25.
//

import Foundation

struct CarbonEstimate: Codable {
    let data: CarbonData
    
    struct CarbonData: Codable {
        let attributes: CarbonAttributes
    }
    
    struct CarbonAttributes: Codable {
        let carbonKg: Double
        
        enum CodingKeys: String, CodingKey {
            case carbonKg = "carbon_kg"
        }
    }
}

class CarbonService {
    private let apiKey = "CHAVE_DA_API" // Substitua com a chave da Carbon Interface
    private let baseURL = "https://www.carboninterface.com/api/v1/estimates"
    private let vehicleModelId = "3a326945-8dbc-4e6d-a659-c32f03196407"
    
    func calculateEmissions(distanceKm: Double) async throws -> Double {
        let body: [String: Any] = [
            "type": "vehicle",
            "distance_unit": "km",
            "distance_value": distanceKm,
            "vehicle_model_id": vehicleModelId
        ]
        
        // Debug: Imprimir o body da requisição
        print("Carbon API - Request Body:", body)
        
        var request = URLRequest(url: URL(string: baseURL)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        // Debug: Imprimir os headers da requisição
        print("Carbon API - Request Headers:", request.allHTTPHeaderFields ?? [:])
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Debug: Imprimir o status code e response
            if let httpResponse = response as? HTTPURLResponse {
                print("Carbon API - Status Code:", httpResponse.statusCode)
            }
            
            // Debug: Imprimir a resposta JSON
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Carbon API - Response:", jsonString)
            }
            
            let estimate = try JSONDecoder().decode(CarbonEstimate.self, from: data)
            print("Carbon API - Decoded carbonKg:", estimate.data.attributes.carbonKg)
            
            return estimate.data.attributes.carbonKg
        } catch {
            // Debug: Imprimir qualquer erro que ocorra
            print("Carbon API - Error:", error)
            throw error
        }
    }
} 
