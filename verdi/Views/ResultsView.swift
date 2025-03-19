//
//  ResultsView.swift
//  verdi
//
//  Created by Carolina Pinsdorf on 17/03/25.
//

import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var viewModel: RouteViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Resultados")
                    .font(.title)
                    .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("De: \(viewModel.currentOrigin)")
                        .font(.subheadline)
                    Text("Para: \(viewModel.currentDestination)")
                        .font(.subheadline)
                }
                .padding(.horizontal)
                
                Text("Tempo estimado por meio de transporte:")
                    .font(.headline)
                    .padding(.top)
                
                ForEach(viewModel.transportModes) { mode in
                    HStack {
                        Image(systemName: mode.icon)
                            .font(.title2)
                            .frame(width: 40)
                        
                        VStack(alignment: .leading) {
                            Text(mode.type.rawValue.capitalized)
                                .font(.headline)
                            Text(mode.duration)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                
                Spacer()
            }
        }
        .navigationTitle("Resultados")
    }
}

//#Preview {
//    ResultsView()
//        .environmentObject(RouteViewModel())
//} 
