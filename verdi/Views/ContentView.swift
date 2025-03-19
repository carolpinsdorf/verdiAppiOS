//
//  ContentView.swift
//  verdi
//
//  Created by Carolina Pinsdorf on 17/03/25.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("hasSeenWelcome") private var hasSeenWelcome: Bool = false
    
    var body: some View {
        if !hasSeenWelcome {
            WelcomeView(hasSeenWelcome: $hasSeenWelcome)
        } else {
            MainTabView()
        }
    }
} 

//#Preview {
//    ContentView()
//        .environmentObject(RouteViewModel())
//}
