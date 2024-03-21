import SwiftUI
import Firebase

struct IniciarSesionOnDatabaseView: View {
    @Binding var email: String
    @Binding var contrasenia: String
    @Binding var showProgressBar: Bool
    @Binding var showAlert: Bool
    @Binding var isLoggedIn: Bool
    @State private var navigateToContentView = false
    
    
    var body: some View {
        VStack {
            Button(action: signIn) {
                Text("Iniciar sesión")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50.0)
                    .background(Color("PrimaryVariation"))
                    .cornerRadius(5)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
            }
        }.navigationBarHidden(true)
    }
    
    func signIn() {
        showProgressBar = true
        Auth.auth().signIn(withEmail: email, password: contrasenia) { authResult, error in
            if let error = error {
                print("Error al iniciar sesión: \(error.localizedDescription)")
                showProgressBar = false
                showAlert = true
            } else {
                print("Inicio de sesión exitoso para el usuario: \(authResult?.user.uid ?? "Unknown")")
                navigateToContentView = true
                showProgressBar = false
                isLoggedIn = true
            }
        }
    }
}


struct IrAregistrarseView:View{
    @Binding var isLoggedIn: Bool
    var body: some View{
        NavigationLink(destination: RegistrarseView(isLoggedIn: $isLoggedIn)) {
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

struct ProgressBarView:View{
    @Binding var show: Bool
    var message: String
    
    var body: some View{
        if show{
            ProgressView(message)
                .progressViewStyle(CircularProgressViewStyle(tint: Color("PrimaryVariation")))
                .padding()
                .cornerRadius(8)
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
