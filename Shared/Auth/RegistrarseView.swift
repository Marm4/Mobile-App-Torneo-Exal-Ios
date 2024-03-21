import SwiftUI
import Firebase

struct RegistrarseView: View {
    @State private var email: String = ""
    @State private var contrasenia: String = ""
    @State private var repetirContrasenia: String = ""
    @State private var showProgressBar: Bool = false
    @State private var showAlert: Bool = false
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()
                
                VStack{
                    EmailView(email: $email)
                    ContraseniaView(contrasenia: $contrasenia, type: "Contraseña")
                    ContraseniaView(contrasenia: $repetirContrasenia, type: "Repetir contraseña")
                    
                    Spacer()
                    Spacer()
                    
                    ProgressBarView(show: $showProgressBar, message: "Creando usuario...")
                    /*if showProgressBar{
                        ProgressView("Creando usuario...")
                            .progressViewStyle(CircularProgressViewStyle(tint: Color("PrimaryVariation")))
                            .padding()
                            .cornerRadius(8)
                    }
                    */
                    Spacer()
                    
                }.alert(isPresented: $showAlert) {
                    Alert(title: Text("Error al crear usuario"),
                          message: Text("Las contraseñas no coinciden"),
                          dismissButton: .default(Text("Aceptar")))
                }
                
                
                
                VStack {
                    
                    Button(action: {
                        guard contrasenia == repetirContrasenia else {
                            print("Las contraseñas no coinciden")
                            showAlert = true
                            return
                        }
                        showProgressBar = true
                        Auth.auth().createUser(withEmail: email, password: contrasenia) { authResult, error in
                            if let error = error {
                                print("Error al crear usuario: \(error.localizedDescription)")
                                showProgressBar = false
                            } else {
                                print("Usuario creado exitosamente")
                                showProgressBar = false
                                isLoggedIn = true
                            }
                        }
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
