//
//  ContentView.swift
//  verdi
//
//  Created by Carolina Pinsdorf on 17/03/25.
//

import SwiftUI

struct ContentView: View {
    @State private var hasSeenWelcome: Bool = UserDefaults.standard.bool(forKey: "hasSeenWelcome")
    
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
