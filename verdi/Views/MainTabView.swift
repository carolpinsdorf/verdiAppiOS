//
//  MainTabView.swift
//  verdi
//
//  Created by Carolina Pinsdorf on 17/03/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            RouteInputView()
                .tabItem {
                    Label("Nova Rota", systemImage: "map")
                }
            
            HistoryView()
                .tabItem {
                    Label("Histórico", systemImage: "clock")
                }
            
            TipsView()
                .tabItem {
                    Label("Dicas", systemImage: "leaf")
                }
        }
    }
} 
