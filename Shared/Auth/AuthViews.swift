import SwiftUI
import Firebase

struct IniciarSesionOnDatabaseView: View {
    @Binding var email: String
    @Binding var contrasenia: String
    @State private var navigateToContentView = false
    
    var body: some View {
        NavigationLink(destination: ContentView(), isActive: $navigateToContentView) {
            EmptyView()
        }
        .hidden()
        .onAppear {
            signIn(email: email, password: contrasenia)
        }
        .buttonStyle(MyButtonStyle())
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error al iniciar sesión: \(error.localizedDescription)")
            } else {
                print("Inicio de sesión exitoso para el usuario: \(authResult?.user.uid ?? "Unknown")")
                navigateToContentView = true
            }
        }
    }
}

struct MyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(.white)
            .background(Color("PrimaryVariation"))
            .cornerRadius(5)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
    }
}
struct IrAregistrarseView:View{
    var body: some View{
        NavigationLink(destination: RegistrarseView()) {
            Text("Registrarse")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50.0)
                .background(Color("Primary"))
                .cornerRadius(5)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
        }
        
        .navigationBarTitle("Iniciar sesion", displayMode: .inline)
        .navigationBarHidden(true)
        
        .navigationTitle("Atras")
        .onAppear {
            
            
            let appearance = UINavigationBarAppearance()
            
            appearance.configureWithOpaqueBackground()
            
            
            let backItemAppearance = UIBarButtonItemAppearance()
            backItemAppearance.normal.titleTextAttributes = [.foregroundColor : UIColor.white] // fix text color
            appearance.backButtonAppearance = backItemAppearance
            
            let image = UIImage(systemName: "chevron.backward")?.withTintColor(.white, renderingMode: .alwaysOriginal) // fix indicator color
            appearance.setBackIndicatorImage(image, transitionMaskImage: image)
            appearance.largeTitleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 20)!]
            appearance.backgroundColor = UIColor(named: "Primary")
            appearance.titleTextAttributes = [
                .font: UIFont.boldSystemFont(ofSize: 18),
                .foregroundColor: UIColor.white
            ]
            
            
            UINavigationBar.appearance().tintColor = .white // probably not needed
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            
            
            
        }
        .navigationBarHidden(true)
    }
}


struct ContraseniaView:View{
    @Binding var contrasenia: String
    var type: String
    
    var body: some View{
        HStack {
            Text(type)
                .font(.headline)
                .fontWeight(.semibold)
            
            Spacer()
        }
        .padding(.leading, 20.0)
        
        HStack{
            SecureField(type, text: $contrasenia)
                .padding(.leading, 15.0)
                .frame(height: 50.0)
                .background(Color("Gris"))
                .foregroundColor(Color("GrisOscuro"))
                .cornerRadius(5)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
            if contrasenia.count > 0{
                if contrasenia.count >= 8{
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 32)) // Cambia el tamaño del icono
                        .foregroundColor(.green)
                        .padding(.trailing)
                    
                }
                else{
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 32)) // Cambia el tamaño del icono
                        .foregroundColor(.red)
                        .padding(.trailing)
                }
            }else{
                Image(systemName: "circle.fill")
                    .font(.system(size: 32))
                    .foregroundColor(Color("Gris"))
                    .padding(.trailing)
            }
        }
    }
}

struct EmailView:View{
    @Binding var email: String
    
    var body: some View{
        HStack {
            Text("Email")
                .font(.headline)
                .fontWeight(.semibold)
            
            Spacer()
        }
        .padding(.leading, 20.0)
        
        HStack{
            TextField("Email", text: Binding<String>(
                get: { self.email },
                set: { self.email = $0.lowercased() }
            ))
            .padding(.leading, 15.0)
            .frame(height: 50.0)
            .background(Color("Gris"))
            .foregroundColor(Color("GrisOscuro"))
            .cornerRadius(5)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            
            if email.count > 0 {
                if email.hasSuffix(".com"){
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 32)) // Cambia el tamaño del icono
                        .foregroundColor(.green)
                        .padding(.trailing)
                    
                }
                else{
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 32)) // Cambia el tamaño del icono
                        .foregroundColor(.red)
                        .padding(.trailing)
                }
                
            } else {
                Image(systemName: "circle.fill")
                    .font(.system(size: 32)) // Cambia el tamaño del icono
                    .foregroundColor(Color("Gris"))
                    .padding(.trailing)
            }
            
            
        }
    }
}
