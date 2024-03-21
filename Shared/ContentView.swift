import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State private var isLoggedIn = false
    @State private var torneo: Torneo = Torneo()
    @State private var torneoLoaded: Bool = false
    
    init() {
        _isLoggedIn = State(initialValue: Auth.auth().currentUser != nil)
        }
    
    
    var body: some View {
            if isLoggedIn {
                if torneoLoaded {
                    MainTabView(isLoggedIn: $isLoggedIn, torneo: torneo)
                } else {
                    ProgressView()
                        .onAppear {
                            loadTorneoData()
                        }
                }
            } else {
                IniciarSesionView(isLoggedIn: $isLoggedIn)
            }
        }
    
    private func loadTorneoData() {
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            torneo.findFixtures() {
                dispatchGroup.leave()
            }
            dispatchGroup.enter()
            torneo.findEquipos() {
                dispatchGroup.leave()
            }
            dispatchGroup.notify(queue: .main) {
                self.torneoLoaded = true
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
    var torneo : Torneo
    var body: some View {
        
        TabView{
        
            ItemView(view: AnyView(FixturesView(torneo: torneo)), imageName: "sportscourt.fill", text: "Partidos")
            ItemView(view: AnyView(FixturesView(torneo: torneo)), imageName: "rosette", text: "Posiciones")
            ItemView(view: AnyView(FixturesView(torneo: torneo)), imageName: "chart.bar.fill", text: "Estadísticas")
            ItemView(view: AnyView(FixturesView(torneo: torneo)), imageName: "calendar", text: "Fixture")
            ItemView(view: AnyView(FixturesView(torneo: torneo)), imageName: "shield.fill", text: "Equipos")
            
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
