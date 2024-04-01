import SwiftUI
import Firebase

struct IniciarSesionView: View {
    @Binding  var isLoggedIn: Bool
    var body: some View {
        MainView(isLoggedIn: $isLoggedIn)
    }
}

struct MainView: View{
    @State private var email: String = ""
    @State private var contrasenia: String = ""
    @State private var showProgressBar: Bool = false
    @State private var showAlert: Bool = false
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                TitleView(text:"Iniciar sesión")
                Spacer()
                
                
                VStack{
                    EmailView(email: $email)
                    ContraseniaView(contrasenia: $contrasenia, type: "Contraseña")
                    
                    Spacer()
                    Spacer()
                    
                    ProgressBarView(show: $showProgressBar, message: "Iniciando sesión...")
        
                    Spacer()
                }.alert(isPresented: $showAlert) {
                    Alert(title: Text("Error al iniciar sesión"),
                          message: Text("Hubo un error al iniciar sesión. Por favor, verifica email y contraseña."),
                          dismissButton: .default(Text("Aceptar")))
                }
                
                
                VStack {
                    IniciarSesionOnDatabaseView(email: $email, contrasenia: $contrasenia, showProgressBar: $showProgressBar, showAlert: $showAlert, isLoggedIn: $isLoggedIn)
                    IrAregistrarseView(isLoggedIn: $isLoggedIn)
                    
                }
                
            }
        }
        .navigationBarTitle("4", displayMode: .inline)
        
    }
}
