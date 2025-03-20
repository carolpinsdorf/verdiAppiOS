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
            
            Image("logo-sem-fundo")
                .resizable()
                .scaledToFit()
                .frame(width: 250)
            
            Text("Seja bem-vinde!")
                .font(.title)
                .bold()
                .foregroundColor(Theme.textColor)
            
            Text("Compare as emissões de CO₂ dos diferentes meios de transporte e faça escolhas mais sustentáveis para suas viagens.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.bottom, 15)
                .foregroundColor(Theme.textColor)
                .font(.system(size: 22))
            
            //Spacer(minLength: 0)
            
            Button(action: {
                withAnimation {
                    hasSeenWelcome = true
                }
            }) {
                Text("Começar")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Theme.darkAccentColor)
                    .foregroundColor(Theme.textColor)
                    .font(.system(size: 20))
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom, 250)
        }
        .padding()
        .background(
            RadialGradient(gradient: Gradient(colors: [Theme.accentColor,Theme.customColor]), center: .center, startRadius: 100, endRadius: 400)
        )
        .edgesIgnoringSafeArea(.all)
    }
}

//#Preview {
//    ContentView()
//        .environmentObject(RouteViewModel())
//}
//
#Preview {
    WelcomeView(hasSeenWelcome: .constant(false))
        .environmentObject(RouteViewModel())
}
