import Foundation

class Fixture {
    var id: String
    private var fechaNro: String
    private var partidos: [Partido]

    init() {
        self.id = ""
        self.fechaNro = ""
        self.partidos = []
    }
    
    init?(data: [String: Any]) {
            guard let id = data["id"] as? String,
                  let fechaNro = data["fechaNro"] as? String,
                  let partidosData = data["partidos"] as? [[String: Any]] else {
                return nil
            }
            
            self.id = id
            self.fechaNro = fechaNro
            
            var partidosArray: [Partido] = []
            for partidoData in partidosData {
                if let partido = Partido(data: partidoData) {
                    partidosArray.append(partido)
                }
            }
            self.partidos = partidosArray
        }
    

    init(id: String, fechaNro: String, partidos: [Partido]) {
        self.id = id
        self.fechaNro = fechaNro
        self.partidos = partidos
    }

    func getId() -> String {
        return id
    }

    func setId(id: String) {
        self.id = id
    }

    func getFechaNro() -> String {
        return fechaNro
    }

    func setFechaNro(fechaNro: String) {
        self.fechaNro = fechaNro
    }

    func getPartidos() -> [Partido] {
        return partidos
    }

    func setPartidos(partidos: [Partido]) {
        self.partidos = partidos
    }
}
