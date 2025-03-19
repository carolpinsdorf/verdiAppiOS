//
//  TipsView.swift
//  verdi
//
//  Created by Carolina Pinsdorf on 17/03/25.
//

import SwiftUI

struct TipsView: View {
    let tips = [
        "Utilize transporte público sempre que possível",
        "Considere usar bicicleta para trajetos curtos",
        "Faça a manutenção regular do seu veículo",
        "Pratique carona compartilhada",
        "Evite acelerações e frenagens bruscas"
    ]
    
    var body: some View {
        NavigationView {
            List(tips, id: \.self) { tip in
                HStack {
                    Image(systemName: "leaf.fill")
                        .foregroundColor(.green)
                    Text(tip)
                }
            }
            .navigationTitle("Dicas Sustentáveis")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        UserDefaults.standard.set(false, forKey: "hasSeenWelcome")
                    }) {
                        Text("Voltar para boas-vindas")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
} 
