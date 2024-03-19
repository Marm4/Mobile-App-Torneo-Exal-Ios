//
//  ContentView.swift
//  Shared
//
//  Created by Marco on 17/03/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            NavigationView {
                
                IniciarSesionView()
                    .navigationBarHidden(true)
            }
            .tabItem {
                Image(systemName: "sportscourt.fill")
                Text("Partidos")
            }
            
            // Pestaña "Posiciones"
            NavigationView {
                VStack {
                    CustomTitleView(title: "Posiciones")
                }
                .navigationBarHidden(true)
            }
            .tabItem {
                Image(systemName: "rosette")
                Text("Posiciones")
            }
            
            // Pestaña "Estadísticas"
            NavigationView {
                VStack {
                    CustomTitleView(title: "Estadísticas")
                }
                .navigationBarHidden(true)
            }
            .tabItem {
                Image(systemName: "chart.bar.fill")
                Text("Estadísticas")
            }
            
            // Pestaña "Más"
            NavigationView {
                VStack {
                    CustomTitleView(title: "Fixture")
                }
                .navigationBarHidden(true)
            }
            .tabItem {
                Image(systemName: "calendar")
                Text("Fixture")
            }
            
            NavigationView {
                VStack {
                    CustomTitleView(title: "Equipos")
                }
                .navigationBarHidden(true)
            }
            .tabItem {
                Image(systemName: "shield.fill")
                Text("Equipos")
            }
        }.navigationBarHidden(true)
        .accentColor(Color("Primary"))
        .background(Color("Primary"))
        .navigationBarHidden(true)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CustomTitleView: View {
    let title: String
    
    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(gradient: Gradient(colors: [Color("Primary"), Color("PrimaryVariation")]), startPoint: .leading, endPoint: .trailing)
                .edgesIgnoringSafeArea(.all)
                .frame(height: 60)
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white) // Color del texto
                .padding(.top, 20)
        }
    }
}

