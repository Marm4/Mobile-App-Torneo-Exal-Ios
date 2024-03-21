import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State private var isLoggedIn = false
    
    init() {
            _isLoggedIn = State(initialValue: Auth.auth().currentUser != nil)
        }
    
    var body: some View {
            if isLoggedIn {
                MainTabView(isLoggedIn: $isLoggedIn)
            } else {
                IniciarSesionView(isLoggedIn: $isLoggedIn)
            }
        }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct MainTabView: View {
    @Binding var isLoggedIn: Bool
    var body: some View {
        
        TabView{
        
            ItemView(view: AnyView(FixturesView()), imageName: "sportscourt.fill", text: "Partidos")
            ItemView(view: AnyView(FixturesView()), imageName: "rosette", text: "Posiciones")
            ItemView(view: AnyView(FixturesView()), imageName: "chart.bar.fill", text: "Estadísticas")
            ItemView(view: AnyView(FixturesView()), imageName: "calendar", text: "Fixture")
            ItemView(view: AnyView(FixturesView()), imageName: "shield.fill", text: "Equipos")
            
        }.navigationBarHidden(true)
        .accentColor(Color("Primary"))
        .background(Color("Primary"))
        .navigationBarHidden(true)
        
    }
    
    func signOut() {
            do {
                try Auth.auth().signOut()
                isLoggedIn = false
            } catch let error as NSError {
                print("Error al cerrar sesión: \(error.localizedDescription)")
            }
        }
}
    
struct ItemView: View {
    var view: AnyView
    var imageName: String
    var text: String
    
    var body: some View {
        NavigationView {
            VStack {
                view
            }
            .navigationBarHidden(true)
        }
        .tabItem {
            Image(systemName: imageName)
            Text(text)
        }
    }
}
