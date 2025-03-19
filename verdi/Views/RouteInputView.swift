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
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                TextField("Origem", text: $viewModel.currentOrigin)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                TextField("Destino", text: $viewModel.currentDestination)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
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
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(13)
                    }
                }
                .disabled(viewModel.currentOrigin.isEmpty || viewModel.currentDestination.isEmpty || viewModel.isLoading)
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Nova Rota")
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
        }
    }
}

//#Preview {
//    RouteInputView()
//        .environmentObject(RouteViewModel())
//} 
