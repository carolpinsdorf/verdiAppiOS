//
//  WelcomeView.swift
//  verdi
//
//  Created by Carolina Pinsdorf on 17/03/25.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var hasSeenWelcome: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: "leaf.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)
            
            Text("Bem-vindo ao Verdí")
                .font(.title)
                .bold()
            
            Text("Compare as emissões de CO₂ dos diferentes meios de transporte e faça escolhas mais sustentáveis para suas viagens.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
            
            Button(action: {
                UserDefaults.standard.set(true, forKey: "hasSeenWelcome")
                hasSeenWelcome = true
            }) {
                Text("Começar")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

//#Preview {
//    ContentView()
//        .environmentObject(RouteViewModel())
//}
//
//#Preview {
//    WelcomeView(hasSeenWelcome: .constant(false))
//        .environmentObject(RouteViewModel())
//}
