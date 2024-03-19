//
//  RegistrarseView.swift
//  Torneo Exal (iOS)
//
//  Created by Marco on 19/03/2024.
//

import SwiftUI

struct RegistrarseView: View {
    @State private var email: String = ""
    @State private var contrasenia: String = ""
    @State private var repetirContrasenia: String = ""
       
       var body: some View {
           NavigationView {
               VStack {
                   
                   Spacer()
                
                VStack{
                    EmailView(email: $email)
                    ContraseniaView(contrasenia: $contrasenia, type: "Contraseña")
                    ContraseniaView(contrasenia: $repetirContrasenia, type: "Repetir contraseña")
                    
                    Spacer()
                    
                }
                
                
                VStack {
                    
                    Button(action: {
                        // Acción cuando se presiona el botón "Registrarse"
                    }) {
                        Text("Registrarse")
                            .fontWeight(/*@START_MENU_TOKEN@*/.semibold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50.0)
                            .background(Color("PrimaryVariation"))
                            .cornerRadius(5)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 5)
                    }
                    
                }
               }
               .navigationBarHidden(true)
                
           }
           
       }
}

struct RegistrarseView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrarseView()
    }
}

