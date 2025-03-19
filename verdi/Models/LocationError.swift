//
//  LocationError.swift
//  verdi
//
//  Created by Carolina Pinsdorf on 18/03/25.
//

import Foundation

enum LocationError: Error {
    case invalidURL
    case invalidResponse
    case noRouteFound
    case apiError(message: String)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "URL inválida"
        case .invalidResponse:
            return "Resposta inválida do servidor"
        case .noRouteFound:
            return "Nenhuma rota encontrada"
        case .apiError(let message):
            return "Erro da API: \(message)"
        }
    }
} 