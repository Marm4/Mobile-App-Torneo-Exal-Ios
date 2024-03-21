import Foundation

class Partido{
    private var diaHora: String
    private var equipoUnoID: String
    private var equipoDosID: String
    private var mvp: Jugador?
    private var fixtureId: String
    private var tarjetas: [Tarjeta]?
    private var golesEquipoUno: [String]?
    private var golesEquipoDos: [String]?

    init(diaHora: String, equipoUnoID: String, equipoDosID: String, mvp: Jugador?, fixtureId: String, tarjetas: [Tarjeta]?, golesEquipoUno: [String]?, golesEquipoDos: [String]?) {
        self.diaHora = diaHora
        self.equipoUnoID = equipoUnoID
        self.equipoDosID = equipoDosID
        self.mvp = mvp
        self.fixtureId = fixtureId
        self.tarjetas = tarjetas
        self.golesEquipoUno = golesEquipoUno
        self.golesEquipoDos = golesEquipoDos
    }
    
    
    init?(data: [String: Any]) {
            guard let diaHora = data["diaHora"] as? String,
                  let equipoUnoID = data["equipoUnoID"] as? String,
                  let equipoDosID = data["equipoDosID"] as? String,
                  let fixtureId = data["fixtureId"] as? String else {
                return nil
            }
            
            self.diaHora = diaHora
            self.equipoUnoID = equipoUnoID
            self.equipoDosID = equipoDosID
            self.fixtureId = fixtureId
            self.mvp = data["mvp"] as? Jugador
            self.tarjetas = data["tarjetas"] as? [Tarjeta]
            self.golesEquipoUno = data["golesEquipoUno"] as? [String]
            self.golesEquipoDos = data["golesEquipoDos"] as? [String]
        }
    

    convenience init() {
        self.init(diaHora: "", equipoUnoID: "", equipoDosID: "", mvp: nil, fixtureId: "", tarjetas: nil, golesEquipoUno: nil, golesEquipoDos: nil)
    }

    func getDiaHora() -> String {
        return diaHora
    }

    func setDiaHora(diaHora: String) {
        self.diaHora = diaHora
    }

    func getEquipoUno() -> String {
        return equipoUnoID
    }

    func setEquipoUno(equipoUno: String) {
        self.equipoUnoID = equipoUno
    }

    func getEquipoDos() -> String {
        return equipoDosID
    }

    func setEquipoDos(equipoDos: String) {
        self.equipoDosID = equipoDos
    }

    func getMvp() -> Jugador? {
        return mvp
    }

    func setMvp(mvp: Jugador?) {
        self.mvp = mvp
    }

    func getFixtureId() -> String {
        return fixtureId
    }

    func setFixtureId(fixtureId: String) {
        self.fixtureId = fixtureId
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

    func getGolesEquipoUno() -> [String]? {
        return golesEquipoUno
    }

    func setGolesEquipoUno(golesEquipoUno: [String]?) {
        self.golesEquipoUno = golesEquipoUno
    }

    func getGolesEquipoDos() -> [String]? {
        return golesEquipoDos
    }

    func setGolesEquipoDos(golesEquipoDos: [String]?) {
        self.golesEquipoDos = golesEquipoDos
    }

    func addGolEquipoUno(idJugador: String) {
        if golesEquipoUno == nil {
            golesEquipoUno = []
        }
        golesEquipoUno?.append(idJugador)
    }

    func removeGolEquipoUno(idJugador: String) {
        if let index = golesEquipoUno?.firstIndex(of: idJugador) {
            golesEquipoUno?.remove(at: index)
        }
    }

    func removeGolEquipoDos(idJugador: String) {
        if let index = golesEquipoDos?.firstIndex(of: idJugador) {
            golesEquipoDos?.remove(at: index)
        }
    }

    func addGolEquipoDos(idJugador: String) {
        if golesEquipoDos == nil {
            golesEquipoDos = []
        }
        golesEquipoDos?.append(idJugador)
    }

    func getResultadoUno() -> Int {
        return golesEquipoUno?.count ?? 0
    }

    func getResultadoDos() -> Int {
        return golesEquipoDos?.count ?? 0
    }

    func removeTarjeta(tarjeta: Tarjeta) {
        if let index = tarjetas?.firstIndex(where: { $0 === tarjeta }) {
            tarjetas?.remove(at: index)
        }
    }
}
