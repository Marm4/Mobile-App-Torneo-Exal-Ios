//
//  IniciarSesionView.swift
//  Torneo Exal (iOS)
//
//  Created by Marco on 18/03/2024.
//

import SwiftUI

struct IniciarSesionView: View {
    @State private var email: String = ""
    @State private var contrasenia: String = ""
       
       var body: some View {
           NavigationView {
               VStack {
                   // ZStack para superponer una vista degradada detrás del texto del título
                   ZStack(alignment: .top) {
                       LinearGradient(gradient: Gradient(colors: [Color("Primary"), Color("PrimaryVariation")]), startPoint: .leading, endPoint: .trailing)
                           .edgesIgnoringSafeArea(.all)
                           .frame(height: 60)
                       
                       Text("Iniciar sesión")
                           .font(.title)
                           .fontWeight(.bold)
                           .foregroundColor(.white) // Color del texto
                           .padding(.top, 20)
                   }
                   
                   Spacer()
                
                VStack{
                    HStack {
                        Text("Email")
                            .font(.headline)
                            .fontWeight(.semibold)
                            
                            Spacer()
                    }
                    .padding(.leading, 20.0)
                
                    TextField("Email", text: $email)
                        .padding(.leading, 15.0)
                        .frame(height: 50.0)
                        .background(Color("Gris"))
                        .foregroundColor(Color("GrisOscuro"))
                        .cornerRadius(5)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                    
                    
                    HStack {
                        Text("Contraseña")
                            .font(.headline)
                            .fontWeight(.semibold)
                            
                            Spacer()
                    }
                    .padding(.leading, 20.0)
                    
                    
                    SecureField("Contraseña", text: $contrasenia)
                        .padding(.leading, 15.0)
                        .frame(height: 50.0)
                        .background(Color("Gris"))
                        .foregroundColor(Color("GrisOscuro"))
                        .cornerRadius(5)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                    
                    Spacer()
                    
                }
                
                
                VStack {
                    Button(action: {
                        // Acción cuando se presiona el botón "Iniciar sesión"
                    }) {
                        Text("Iniciar sesión")
                            .fontWeight(/*@START_MENU_TOKEN@*/.semibold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50.0)
                            .background(Color("PrimaryVariation"))
                            .cornerRadius(5)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 5)
                            
                    }
                    
                
                    
                    Button(action: {
                        // Acción cuando se presiona el botón "Registrarse"
                    }) {
                        Text("Registrarse")
                            .fontWeight(/*@START_MENU_TOKEN@*/.semibold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50.0)
                            .background(Color("Primary"))
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


struct IniciarSesionView_Previews: PreviewProvider {
    static var previews: some View {
        IniciarSesionView()
    }
}
