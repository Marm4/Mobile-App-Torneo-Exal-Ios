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
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(true)

                    
            } else {
                ProgressView()
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(true)
                    .onAppear {
                        loadTorneoData()
                    }
                    
            }
        } else {
            IniciarSesionView(isLoggedIn: $isLoggedIn)
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
                
        }
        
        
    }
    
    private func loadTorneoData() {
        let dispatchGroup = DispatchGroup()
        var equiposLoaded = false
        var imagesLoaded = false

       
        dispatchGroup.enter()
        torneo.findEquipos {
            equiposLoaded = true
            dispatchGroup.leave()
        }

       
        dispatchGroup.notify(queue: .main) {
            if equiposLoaded {
                for equipo in torneo.getEquipos() {
                    dispatchGroup.enter()
                    if let urlEscudo = equipo.getUrlEscudo(){
                        equipo.loadImage(from: urlEscudo) {
                            dispatchGroup.leave()
                        }
                    }
                    else{
                        dispatchGroup.leave()
                    }
                    
                }

               
                dispatchGroup.notify(queue: .main) {
                    imagesLoaded = true
                }

                dispatchGroup.notify(queue: .main) {
                    if imagesLoaded {
                        dispatchGroup.enter()
                        torneo.findFixtures() {
                            dispatchGroup.leave()
                        }
                        dispatchGroup.enter()
                        torneo.findProximaFecha() {
                            dispatchGroup.leave()
                        }
                        dispatchGroup.notify(queue: .main) {
                            self.torneoLoaded = true
                        }
                    }
                }
            }
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
            /*ItemView(view: AnyView(FechaView(fixture: proximaFecha()!, equipos: torneo.getEquipos())), imageName: "sportscourt.fill", text: "Partidos")*/
            ItemView(view: AnyView(PosicionesView(torneo: torneo)), imageName: "rosette", text: "Posiciones")
            ItemView(view: AnyView(GeneralesView(torneo: torneo)), imageName: "chart.bar.fill", text: "Estadísticas")
            ItemView(view: AnyView(FixturesView(torneo: torneo)), imageName: "calendar", text: "Fixture")
            ItemView(view: AnyView(BuscarEquiposView(equipos: torneo.getEquipos(), fixtures: torneo.getFixtures())), imageName: "shield.fill", text: "Equipos")
            
        }
        .accentColor(Color("Primary"))
        .background(Color("Primary"))
        .navigationBarTitle("")
        .navigationBarHidden(true)
       
        
        
    }
    
    func proximaFecha() -> Fixture? {
        for fixture in torneo.getFixtures() {
            if fixture.id == torneo.proximaFecha {
                return fixture
            }
        }
        return nil
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
    @State var isNavigationBarHidden: Bool = true
    var body: some View {
        NavigationView {
            VStack {
                view
            }.navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .tabItem {
            Image(systemName: imageName)
            Text(text)
        }
    }
}
