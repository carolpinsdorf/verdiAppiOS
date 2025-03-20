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
        NavigationStack {
            ZStack {
                VStack(spacing: 25) {
                    Image("logo-sem-fundo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                    
                    Text("Histórico")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(Theme.darkAccentColor)
                        .padding(.top, 20)
                    
                    List(viewModel.routes) { route in
                        VStack(alignment: .leading) {
                            Text("\(route.origin) → \(route.destination)")
                                .font(.headline)
                                .foregroundColor(Theme.textColor) // Usando a cor do tema
                            Text(route.date, style: .date)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                
                        }
                        .padding()
                        .background(Theme.darkAccentColor) // Fundo com cor do tema
                        .cornerRadius(10)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    HistoryView()
        .environmentObject(RouteViewModel())
} 
