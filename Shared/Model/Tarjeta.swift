import Foundation


class Tarjeta {
    var id: String
    private var amarilla: Bool
    private var jugadorId: String

    init(amarilla: Bool, jugadorId: String) {
        self.id = UUID().uuidString
        self.amarilla = amarilla
        self.jugadorId = jugadorId
    }
    
    init?(data: [String: Any]) {
        guard let amarilla = data["amarilla"] as? Bool,
              let jugadorId = data["jugadorId"] as? String
        else {
            return nil
        }
        self.id = UUID().uuidString // Generar automáticamente un ID único
        self.amarilla = amarilla
        self.jugadorId = jugadorId
        
    }
    
    
    
    convenience init() {
        self.init(amarilla: false, jugadorId: "")
    }

    func getAmarilla() -> Bool {
        return amarilla
    }

    func setAmarilla(amarilla: Bool) {
        self.amarilla = amarilla
    }

    func getJugadorId() -> String {
        return jugadorId
    }

    func setJugadorId(jugadorId: String) {
        self.jugadorId = jugadorId
    }
    
    func getId() -> String {
        return id;
    }
}
