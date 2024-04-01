import Foundation

class Partido{
    var id: String = UUID().uuidString
    private var diaHora: String = ""
    private var equipoUno: String = ""
    private var equipoDos: String = ""
    private var mvp: Jugador? = nil
    private var fixtureId: String = ""
    private var tarjetas: [Tarjeta]? = nil
    private var golesEquipoUno: [String]? = nil
    private var golesEquipoDos: [String]? = nil

    
    init?(data: [String: Any]) {
        self.id = UUID().uuidString
        if let diaHora = data["diaHora"] as? String{
            self.diaHora = diaHora
        }
       
        if let equipoUno = data["equipoUno"] as? String{
            self.equipoUno = equipoUno
        }
        if let equipoDos = data["equipoDos"] as? String{
            self.equipoDos = equipoDos
        }
        
        if let fixtureId = data["fixtureId"] as? String{
            self.fixtureId = fixtureId
        }
        
        if let golesEquipoUno = data["golesEquipoUno"] as? [String]{
            self.golesEquipoUno = golesEquipoUno
        }
        
        if let golesEquipoDos = data["golesEquipoDos"] as? [String] {
            self.golesEquipoDos = golesEquipoDos
        }


        
        if let tarjetasData = data["tarjetas"] as? [[String: Any]] {
            var tarjetasArray: [Tarjeta] = []
            for tarjetaData in tarjetasData {
                if let tarjeta = Tarjeta(data: tarjetaData) {
                    tarjetasArray.append(tarjeta)
                }
            }
            self.tarjetas = tarjetasArray
        }
        
        if let mvpData = data["mvp"] as? [String: Any] {
            if let mvp = Jugador(data: mvpData) {
                self.mvp = mvp
            } else {
                self.mvp = nil
            }
        }
    }

    func getDiaHora() -> String {
        return diaHora
    }

    func setDiaHora(diaHora: String) {
        self.diaHora = diaHora
    }

    func getEquipoUno() -> String {
        return equipoUno
    }

    func setEquipoUno(equipoUno: String) {
        self.equipoUno = equipoUno
    }

    func getEquipoDos() -> String {
        return equipoDos
    }

    func setEquipoDos(equipoDos: String) {
        self.equipoDos = equipoDos
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
    
    func isPartidoJugado() -> Bool{
        let fechaActual = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        if let fechaAlmacenada = dateFormatter.date(from: diaHora) {
            // Comparar las fechas
            if fechaAlmacenada > fechaActual {
                return false
            } else if fechaAlmacenada < fechaActual {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
}
