//
//  verdiApp.swift
//  verdi
//
//  Created by Carolina Pinsdorf on 17/03/25.
//

import SwiftUI

@main
struct VerdiApp: App {
    @StateObject private var routeViewModel = RouteViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(routeViewModel)
        }
    }
}
