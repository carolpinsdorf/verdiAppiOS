//
//  DirectionsResponse.swift
//  verdi
//
//  Created by Carolina Pinsdorf on 18/03/25.
//

import Foundation

struct DirectionsResponse: Codable {
    let routes: [DirectionRoute]
}
