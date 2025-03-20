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
        NavigationStack {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [Theme.customColor, Theme.customColor]), center: .center, startRadius: 100, endRadius: 400)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    Image("logo-sem-fundo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)

                    VStack(spacing: 25) {
                        Text("Resultados")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Theme.textColor)
                            .padding(.top, 20)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("De: \(viewModel.currentOrigin)")
                                .font(.system(size: 20))
                                .foregroundColor(Theme.textColor)
                            Text("Para: \(viewModel.currentDestination)")
                                .font(.system(size: 20))
                                .foregroundColor(Theme.textColor)
                        }
                        .padding(.horizontal)
                        
                        ForEach(viewModel.transportModes) { mode in
                            HStack {
                                //icone
                                Image(systemName: mode.icon)
                                    .font(.title2)
                                    .frame(width: 40)
                                    .foregroundColor(.black)
                                
                                //modo
                                VStack(alignment: .leading) {
                                    Text(mode.type.rawValue.capitalized)
                                        .font(.headline)
                                        .foregroundColor(Theme.textColor)
                                    
                                    //duracao
                                    Text(mode.duration)
                                        .font(.subheadline)
                                        .foregroundColor(Color.blue)
                                }
                                
                                Spacer()
                                
                                if let carbonKg = mode.carbonKg {
                                    let formattedValue = String(format: "%.3f kg CO₂", carbonKg)
                                    
                                    if carbonKg == 0 {
                                            Text(formattedValue)
                                                .font(.system(size: 20, weight: .medium))
                                                .foregroundColor(Theme.darkAccentColor) // Cor verde para emissões 0
                                                .bold()
                                        } else {
                                            Text(formattedValue)
                                                .font(.system(size: 20, weight: .medium))
                                                .foregroundColor(.red) // Cor vermelha para emissões > 0
                                                .bold()
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(Theme.darkAccentColor.opacity(0.3))
                            .cornerRadius(10)
                            .padding(.horizontal)
                        }
                        
                        Spacer()
                    }
                    .padding(.bottom, 40)
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
    }


#Preview {
    ResultsView()
        .environmentObject(RouteViewModel())
} 
