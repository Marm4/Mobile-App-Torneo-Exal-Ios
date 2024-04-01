import Foundation
import Firebase

class Torneo{
    private var fixtures:[Fixture] = []
    
    private var equipos:[Equipo] = []
    
    var proximaFecha: String = ""
    
    
    func findFixtures(completion: @escaping () -> Void) {
        let fixtureRef = Database.database().reference().child("fixtures")
        fixtureRef.observeSingleEvent(of: .value) { (snapshot) in
            var fetchedFixtures: [Fixture] = []
            if snapshot.exists() {
                for fixtureSnapshot in snapshot.children {
                    if let fixtureData = (fixtureSnapshot as? DataSnapshot)?.value as? [String: Any] {
                        if let fixture = Fixture(data: fixtureData) {
                            fetchedFixtures.append(fixture)
                            print("Contenido de los partidos:", fixture.getPartidos())
                        }
                    }
                }
            }
            self.fixtures = fetchedFixtures
            completion()
        }
    }
    
    func findEquipos(completion: @escaping () -> Void) {
        let equiposRef = Database.database().reference().child("equipos")
        equiposRef.observeSingleEvent(of: .value) { (snapshot) in
            var fetchedEquipos: [Equipo] = []
            if snapshot.exists() {
                for equipoSnapshot in snapshot.children {
                    if let equipoData = (equipoSnapshot as? DataSnapshot)?.value as? [String: Any] {
                        if let equipo = Equipo(data: equipoData) {
                            fetchedEquipos.append(equipo)
                        }
                    }
                }
            }
            self.equipos = fetchedEquipos
            completion()
        }
    }
    
    func findProximaFecha(completion: @escaping () -> Void) {
        let equiposRef = Database.database().reference().child("proxima-fecha")
        equiposRef.observeSingleEvent(of: .value) { (snapshot) in
            if let proximaFecha = snapshot.value as? String {
                self.proximaFecha = proximaFecha
                completion()
            } else {
                print("No se pudo recuperar la próxima fecha.")
                completion()
            }
        } withCancel: { (error) in
            print("Error al recuperar la próxima fecha: \(error.localizedDescription)")
            completion()
        }
    }
    
    func getEquipos() -> [Equipo]{
        return equipos
    }
    
    func getFixtures() -> [Fixture]{
        return fixtures
    }
    
    
}
