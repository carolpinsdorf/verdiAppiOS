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
        VStack {
            Text("Resultados")
                .font(.title)
                .padding()
            
            // Placeholder para os resultados
            Text("Origem: \(viewModel.currentOrigin)")
            Text("Destino: \(viewModel.currentDestination)")
            
            // Aqui virão os resultados das emissões
            
            Spacer()
        }
        .navigationTitle("Resultados")
    }
}

//#Preview {
//    ResultsView()
//        .environmentObject(RouteViewModel())
//} 
