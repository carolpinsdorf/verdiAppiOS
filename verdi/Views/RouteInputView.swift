//
//  RouteInpurView.swift
//  verdi
//
//  Created by Carolina Pinsdorf on 17/03/25.
//

import SwiftUI

struct RouteInputView: View {
    @EnvironmentObject var viewModel: RouteViewModel
    @State private var showingError = false
    @State private var showingResults = false
    @FocusState private var isOriginFocused: Bool
    @FocusState private var isDestinationFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                Image("logo-sem-fundo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .padding(.top, 50)
                
                Text("Nova Rota")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Theme.textColor)
                    .padding(.top, 140)
                
                TextField("Origem", text: $viewModel.currentOrigin)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding()
                    .background(isOriginFocused ? Theme.darkAccentColor : Theme.customColor)
                    .cornerRadius(10)
                    .foregroundColor(Theme.textColor)
                    .font(.system(size: 20))
                    .padding(.horizontal)
                    .focused($isOriginFocused)
                
                TextField("Destino", text: $viewModel.currentDestination)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding()
                    .background(isDestinationFocused ? Theme.darkAccentColor : Theme.customColor)
                    .cornerRadius(10)
                    .foregroundColor(Theme.textColor)
                    .font(.system(size: 20))
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                    .focused($isDestinationFocused)
                
                Button(action: {
                    Task {
                        await viewModel.calculateRoute()
                        showingResults = true
                    }
                }) {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    } else {
                        Text("Calcular Emissões")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Theme.darkAccentColor)
                            .foregroundColor(Theme.textColor)
                            .cornerRadius(13)
                            .font(.system(size: 20))
                    }
                }
                .disabled(viewModel.currentOrigin.isEmpty || viewModel.currentDestination.isEmpty || viewModel.isLoading)
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $showingResults) {
                ResultsView()
            }
            .alert("Erro", isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.error ?? "Erro desconhecido")
            }
            .onChange(of: viewModel.error) { error in
                showingError = error != nil
            }
            .padding()
            .background(
                RadialGradient(gradient: Gradient(colors: [Theme.accentColor, Theme.customColor]), center: .center, startRadius: 100, endRadius: 400)
            )
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    RouteInputView()
        .environmentObject(RouteViewModel())
} 
