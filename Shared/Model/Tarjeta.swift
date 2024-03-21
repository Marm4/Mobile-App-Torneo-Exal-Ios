import Foundation


class Tarjeta {
    private var amarilla: Bool
    private var jugadorId: String

    init(amarilla: Bool, jugadorId: String) {
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
}
