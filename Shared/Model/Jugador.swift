import Foundation


class Jugador {
    private var id: String
    private var nombre: String
    private var goles: Int
    private var tarjetas: [Tarjeta]?
    private var partidosJugados: Int

    init() {
        self.id = ""
        self.nombre = ""
        self.goles = 0
        self.tarjetas = nil
        self.partidosJugados = 0
    }

    init(id: String, nombre: String, goles: Int, tarjetas: [Tarjeta]?, partidosJugados: Int) {
        self.id = id
        self.nombre = nombre
        self.goles = goles
        self.tarjetas = tarjetas
        self.partidosJugados = partidosJugados
    }
    
    init?(data: [String: Any]) {
            guard let id = data["id"] as? String,
                  let nombre = data["nombre"] as? String,
                  let goles = data["goles"] as? Int,
                  let partidosJugados = data["partidosJugados"] as? Int else {
                return nil
            }

            self.id = id
            self.nombre = nombre
            self.goles = goles
            self.partidosJugados = partidosJugados
            
            // Opcionalmente inicializamos las propiedades opcionales si existen en el diccionario
            self.tarjetas = data["tarjetas"] as? [Tarjeta]
        }

    func getId() -> String {
        return id
    }

    func setId(id: String) {
        self.id = id
    }

    func getNombre() -> String {
        return nombre
    }

    func setNombre(nombre: String) {
        self.nombre = nombre
    }

    func getGoles() -> Int {
        return goles
    }

    func setGoles(goles: Int) {
        self.goles = goles
    }

    func getTarjetas() -> [Tarjeta]? {
        return tarjetas
    }

    func setTarjetas(tarjetas: [Tarjeta]?) {
        self.tarjetas = tarjetas
    }

    func addTarjeta(tarjeta: Tarjeta) {
        if tarjetas == nil {
            tarjetas = []
        }
        tarjetas?.append(tarjeta)
    }

    func getPartidosJugados() -> Int {
        return partidosJugados
    }

    func setPartidosJugados(partidosJugados: Int) {
        self.partidosJugados = partidosJugados
    }

    func addGol() {
        goles += 1
    }

    func removeGol() {
        goles -= 1
    }

    func removeTarjeta(tarjeta: Tarjeta) {
        if let index = tarjetas?.firstIndex(where: { $0 === tarjeta }) {
            tarjetas?.remove(at: index)
        }
    }
}
