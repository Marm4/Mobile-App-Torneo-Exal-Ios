import Foundation


class TablaPosiciones{
    var tablaEquipos: [TablaEquipo]
    var fixtures: [Fixture]
    var equipos: [Equipo]
    
    init(torneo: Torneo){
        self.tablaEquipos = []
        self.fixtures = torneo.getFixtures()
        self.equipos = torneo.getEquipos()
        
        for equipo in equipos{
            let tablaEquipo = TablaEquipo(equipo: equipo)
            let values = getValues(equipo: equipo)
            
            tablaEquipo.partidosJugados = values[0]
            tablaEquipo.puntos = values[1]
            tablaEquipo.diferenciaGoles = values[2]

            tablaEquipos.append(tablaEquipo)
        }
        
        tablaEquipos.sort { (equipo1, equipo2) -> Bool in
            if equipo1.puntos != equipo2.puntos {
                return equipo1.puntos > equipo2.puntos
            } else {
                return equipo1.diferenciaGoles > equipo2.diferenciaGoles
            }
        }
        
        var i = 1
        for equipo in tablaEquipos{
            equipo.posicion = i
            i = i+1
        }
        
    }
    
    class TablaEquipo{
        var id: String
        var posicion: Int = 0
        var equipo: Equipo
        var partidosJugados: Int = 0
        var diferenciaGoles: Int = 0
        var puntos: Int = 0
        
        init(equipo: Equipo){
            self.id = UUID().uuidString 
            self.equipo = equipo
        }
    }
    
    func getValues(equipo: Equipo) -> [Int]{
        var partidos = 0
        var puntos = 0
        var golesFavor = 0
        var golesContra = 0
        
        
        for fixture in fixtures{
            for partido in fixture.getPartidos(){
                
                golesFavor = golesFavor + getValue(idComparar: partido.getEquipoUno(), idEquipo: equipo.getId()!, golesUno: (partido.getGolesEquipoUno()?.count ?? 0), golesDos: (partido.getGolesEquipoDos()?.count ?? 0), aFavor: true, getGoles: true)
                golesFavor = golesFavor + getValue(idComparar: partido.getEquipoDos(), idEquipo: equipo.getId()!, golesUno: (partido.getGolesEquipoDos()?.count ?? 0), golesDos: (partido.getGolesEquipoUno()?.count ?? 0), aFavor: true, getGoles: true)
                
                golesContra = golesContra + getValue(idComparar: partido.getEquipoUno(), idEquipo: equipo.getId()!, golesUno: (partido.getGolesEquipoUno()?.count ?? 0), golesDos: (partido.getGolesEquipoDos()?.count ?? 0), aFavor: false,getGoles: true)
                golesContra = golesContra + getValue(idComparar: partido.getEquipoDos(), idEquipo: equipo.getId()!, golesUno: (partido.getGolesEquipoDos()?.count ?? 0), golesDos: (partido.getGolesEquipoUno()?.count ?? 0), aFavor: false, getGoles: true)
                
                
                if partido.getEquipoUno() == equipo.getId() || partido.getEquipoDos() == equipo.getId(){
                    if partido.isPartidoJugado(){
                        partidos = partidos + 1
                    }
                }
                
               
                puntos = puntos + getValue(idComparar: partido.getEquipoUno(), idEquipo: equipo.getId()!, golesUno: (partido.getGolesEquipoUno()?.count ?? 0), golesDos: (partido.getGolesEquipoDos()?.count ?? 0), aFavor: false, getGoles: false)
                puntos = puntos + getValue(idComparar: partido.getEquipoDos(), idEquipo: equipo.getId()!, golesUno: (partido.getGolesEquipoDos()?.count ?? 0), golesDos: (partido.getGolesEquipoUno()?.count ?? 0), aFavor: false, getGoles: false)
                
            }
        }
        
        let diferenciaGoles = golesFavor - golesContra
        return [partidos, puntos, diferenciaGoles]
    }
    

    
    func getValue(idComparar: String, idEquipo: String, golesUno: Int, golesDos: Int, aFavor: Bool, getGoles: Bool) -> Int {
        var value = 0
        if idComparar == idEquipo{
            if getGoles{
                if aFavor{
                    value = golesUno
                }
                else{
                    value = golesDos
                }
            }
            else{
                if golesUno > golesDos{
                    value = 3
                }
                else if golesUno == golesDos{
                    value = 1
                }
            }
        }
        return value
    }
}

