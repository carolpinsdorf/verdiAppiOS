//
//  DirectionRoute.swift
//  verdi
//
//  Created by Carolina Pinsdorf on 18/03/25.
//

import Foundation

struct DirectionRoute: Codable {
    let legs: [Leg]
    let overviewPolyline: Polyline
    
    enum CodingKeys: String, CodingKey {
        case legs
        case overviewPolyline = "overview_polyline"
    }
}
