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
} 