//
//  TransportMode.swift
//  verdi
//
//  Created by Carolina Pinsdorf on 19/03/25.
//

import Foundation

struct TransportMode: Identifiable {
    let id = UUID()
    let type: Route.TransportType
    let duration: String
    let icon: String
    
    static func getIcon(for type: Route.TransportType) -> String {
        switch type {
        case .car: return "car.fill"
        case .bus: return "bus.fill"
        case .train: return "tram.fill"
        case .bike: return "bicycle"
        case .walk: return "figure.walk"
        }
    }
} 
