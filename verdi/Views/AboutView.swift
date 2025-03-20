//
//  AboutView.swift
//  verdi
//
//  Created by Carolina Pinsdorf on 17/03/25.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Fundo da view
                Theme.accentColor // Usando a cor de destaque como fundo
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Logo no topo
                        Image("logo-sem-fundo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                            .padding(.top, 1)
                        
                        Text("Sobre o Verdí")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Theme.textColor)
                            .padding(.top, 20)
                        
                        // Seção: Sobre o App
                        VStack(alignment: .leading, spacing: 12) {
                            Text("O Verdí é um aplicativo desenvolvido para ajudar você a fazer escolhas de transporte mais conscientes e sustentáveis, calculando e comparando as emissões de CO₂ de diferentes meios de transporte.")
                                .foregroundColor(Theme.textColor)
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.system(size: 20))
                        }
                        
                        // Seção: Funcionalidades
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Funcionalidades")
                                .bold()
                                .font(.title2)
                                .foregroundColor(Theme.textColor)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                FunctionalityRow(icon: "map", text: "Cálculo de rotas entre dois pontos")
                                FunctionalityRow(icon: "car", text: "Comparação de tempo entre diferentes meios de transporte")
                                FunctionalityRow(icon: "leaf", text: "Cálculo de emissões de CO₂ para cada opção")
                                FunctionalityRow(icon: "clock", text: "Histórico de rotas calculadas")
                            }.font(.system(size: 20))
                        }
                        
                        // Seção: Objetivo
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Objetivo")
                                .bold()
                                .font(.title2)
                                .foregroundColor(Theme.textColor)
                            
                            Text("Nosso objetivo é conscientizar sobre o impacto ambiental das escolhas de transporte diárias. Ao mostrar as emissões de CO₂ de cada opção, queremos ajudar você a tomar decisões mais sustentáveis, contribuindo para a redução da pegada de carbono e a preservação do meio ambiente.")
                                .foregroundColor(Theme.textColor)
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.system(size: 20))
                        }
                        
                        // Seção: Como Usar
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Como Usar")
                                .font(.title2)
                                .foregroundColor(Theme.textColor)
                                .bold()
                            
                            Text("1. Digite os endereços de origem e destino\n2. Toque em 'Calcular Emissões'\n3. Compare as opções de transporte\n4. Veja o tempo estimado e as emissões de CO₂ de cada opção\n5. Escolha a opção mais adequada considerando tempo e impacto ambiental")
                                .foregroundColor(Theme.textColor)
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.system(size: 20))
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle("") // Removendo o título da barra de navegação
            .navigationBarTitleDisplayMode(.inline)
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
                .foregroundColor(Theme.textColor) // Usando a cor do tema
        }
    }
}

#Preview {
    AboutView()
} 
