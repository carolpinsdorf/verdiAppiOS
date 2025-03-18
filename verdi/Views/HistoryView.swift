//
//  HistoryView.swift
//  verdi
//
//  Created by Carolina Pinsdorf on 17/03/25.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var viewModel: RouteViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.routes) { route in
                VStack(alignment: .leading) {
                    Text("\(route.origin) → \(route.destination)")
                        .font(.headline)
                    Text(route.date, style: .date)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Histórico")
        }
    }
} 
