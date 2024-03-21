import Foundation


class Equipo {
    var id: String?
    private var nombre: String
    private var escudo: URL?
    private var urlEscudo: String?
    private var jugadores: [Jugador]?
    private var partidos: [Partido]?
    private var colores: [Int]?

    init() {
        self.id = nil
        self.nombre = ""
    }

    init(nombre: String, escudo: URL?, jugadores: [Jugador]?, partidos: [Partido]?) {
        self.nombre = nombre
        self.escudo = escudo
        self.jugadores = jugadores
        self.partidos = partidos
    }

    init(id: String, nombre: String, escudo: URL?, urlEscudo: String?, jugadores: [Jugador]?, partidos: [Partido]?, colores: [Int]?) {
        self.id = id
        self.nombre = nombre
        self.escudo = escudo
        self.urlEscudo = urlEscudo
        self.jugadores = jugadores
        self.partidos = partidos
        self.colores = colores
    }
    
    init?(data: [String: Any]) {
            guard let nombre = data["nombre"] as? String else {
                return nil
            }

            self.nombre = nombre
            self.id = data["id"] as? String
            self.escudo = data["escudo"] as? URL
            self.urlEscudo = data["urlEscudo"] as? String
            self.jugadores = data["jugadores"] as? [Jugador]
            self.partidos = data["partidos"] as? [Partido]
            self.colores = data["colores"] as? [Int]
        }

    func getNombre() -> String {
        return nombre
    }

    func setNombre(nombre: String) {
        self.nombre = nombre
    }

    func getEscudo() -> URL? {
        return escudo
    }

    func setEscudo(escudo: URL?) {
        self.escudo = escudo
    }

    func getJugadores() -> [Jugador]? {
        return jugadores
    }

    func getPartidos() -> [Partido]? {
        return partidos
    }

    func setJugadores(jugadores: [Jugador]?) {
        self.jugadores = jugadores
    }

    func setPartidos(partidos: [Partido]?) {
        self.partidos = partidos
    }

    func addJugador(jugador: Jugador) {
        if jugadores == nil {
            jugadores = []
        }
        jugadores?.append(jugador)
    }

    func addPartido(partido: Partido) {
        if partidos == nil {
            partidos = []
        }
        partidos?.append(partido)
    }

    func getId() -> String? {
        return id
    }

    func setId(id: String) {
        self.id = id
    }

    func getUrlEscudo() -> String? {
        return urlEscudo
    }

    func setUrlEscudo(urlEscudo: String?) {
        self.urlEscudo = urlEscudo
    }

    func buscarJugadorPorId(id: String) -> Jugador? {
        return jugadores?.first(where: { $0.getId() == id })
    }

    func getColores() -> [Int]? {
        return colores
    }

    func setColores(colores: [Int]?) {
        self.colores = colores
    }
}
