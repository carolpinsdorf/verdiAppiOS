//
//  routeUntitled.swift
//  verdi
//
//  Created by Carolina Pinsdorf on 18/03/25.
//

import Foundation

struct Route: Codable, Identifiable {
    let id: UUID
    let origin: String
    let destination: String
    let distance: Double?
    let emission: Double
    let date: Date
    
    struct TransitionEmission: Codable {
        let type: TransportType
        let co2Amount: Double
    }
    
    enum TransportType: String, Codable {
        case car
        case bus
        case train
        case bike
        case walk
    }
}
