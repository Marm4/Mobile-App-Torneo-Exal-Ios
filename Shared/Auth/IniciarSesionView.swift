import SwiftUI
import Firebase

struct IniciarSesionView: View {
    
    
    var body: some View {
        MainView()
        
    }
}


struct IniciarSesionView_Previews: PreviewProvider {
    static var previews: some View {
        IniciarSesionView()
    }
}

struct MainView: View{
    @State private var email: String = ""
    @State private var contrasenia: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
               
                ZStack(alignment: .top) {
                    LinearGradient(gradient: Gradient(colors: [Color("Primary"), Color("PrimaryVariation")]), startPoint: .leading, endPoint: .trailing)
                        .edgesIgnoringSafeArea(.all)
                        .frame(height: 40)
                    
                    Text("Iniciar sesión")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                VStack{
                    EmailView(email: $email)
                    ContraseniaView(contrasenia: $contrasenia, type: "Contraseña")
                    
                    Spacer()
                    
                }
                
                
                VStack {
                    IniciarSesionOnDatabaseView(email: $email, contrasenia: $contrasenia)
                    IrAregistrarseView()
                    
                }
            }
        }
    }
    
}
