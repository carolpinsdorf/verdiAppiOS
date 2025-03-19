//
//  AboutView.swift
//  verdi
//
//  Created by Carolina Pinsdorf on 17/03/25.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Seção: Sobre o App
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Sobre o Verdí", systemImage: "leaf.fill")
                            .font(.title2)
                            .foregroundColor(.green)
                        
                        Text("O Verdí é um aplicativo desenvolvido para ajudar você a fazer escolhas de transporte mais conscientes e sustentáveis, calculando e comparando as emissões de CO₂ de diferentes meios de transporte.")
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    // Seção: Funcionalidades
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Funcionalidades", systemImage: "star.fill")
                            .font(.title2)
                            .foregroundColor(.green)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            FunctionalityRow(icon: "map", text: "Cálculo de rotas entre dois pontos")
                            FunctionalityRow(icon: "car", text: "Comparação de tempo entre diferentes meios de transporte")
                            FunctionalityRow(icon: "leaf", text: "Cálculo de emissões de CO₂ para cada opção")
                            FunctionalityRow(icon: "clock", text: "Histórico de rotas calculadas")
                        }
                    }
                    
                    // Seção: Objetivo
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Objetivo", systemImage: "target")
                            .font(.title2)
                            .foregroundColor(.green)
                        
                        Text("Nosso objetivo é conscientizar sobre o impacto ambiental das escolhas de transporte diárias. Ao mostrar as emissões de CO₂ de cada opção, queremos ajudar você a tomar decisões mais sustentáveis, contribuindo para a redução da pegada de carbono e a preservação do meio ambiente.")
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    // Seção: Como Usar
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Como Usar", systemImage: "questionmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.green)
                        
                        Text("1. Digite os endereços de origem e destino\n2. Toque em 'Calcular Emissões'\n3. Compare as opções de transporte\n4. Veja o tempo estimado e as emissões de CO₂ de cada opção\n5. Escolha a opção mais adequada considerando tempo e impacto ambiental")
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding()
            }
            .navigationTitle("Sobre")
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

// View auxiliar para as funcionalidades
struct FunctionalityRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.green)
                .frame(width: 24)
            Text(text)
        }
    }
} 
