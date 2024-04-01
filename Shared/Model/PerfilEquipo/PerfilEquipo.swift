import Foundation

class PerfilEquipo{
    var equipo : Equipo
    var equipos: [Equipo]
    var jugadores: [JugadorEstadistica] = []
    var partidoEstadisticas: [PartidosEstadistica] = []
    var goles: Int = 0
    var partidos: Int = 0
    var puntos: Int = 0

    init(equipo: Equipo, fixtures: [Fixture], equipos: [Equipo]) {
        self.equipo = equipo
        self.equipos = equipos
        
        for jugador in equipo.getJugadores()!{
            let jugadorEst = JugadorEstadistica()
            jugadorEst.id = jugador.getId()
            jugadorEst.nombre = jugador.getNombre()
            self.jugadores.append(jugadorEst)
        }
        
        
        for fixture in fixtures{
            let partidos = fixture.getPartidos()
            for partido in partidos{
                buscarEstadisticas(equipoId: partido.getEquipoUno(), partido: partido, fixture: fixture, golesUno: partido.getGolesEquipoUno() ?? [], golesDos: partido.getGolesEquipoDos() ?? [], rival: partido.getEquipoDos())
                
                buscarEstadisticas(equipoId: partido.getEquipoDos(), partido: partido, fixture: fixture, golesUno: partido.getGolesEquipoDos() ?? [], golesDos: partido.getGolesEquipoUno() ?? [], rival: partido.getEquipoUno())
            }
        }
            
    }
    
    func buscarEstadisticas(equipoId: String, partido: Partido, fixture: Fixture, golesUno: [String], golesDos: [String], rival: String){
        if equipoId == equipo.getId(){
            findPuntos(resultadoUno: golesUno.count, resultadoDos: golesDos.count)
            self.partidos += 1
            self.goles += golesUno.count
            let partidoEst = PartidosEstadistica()
            partidoEst.fecha = fixture.getFechaNro()
            partidoEst.resultado = "\(golesUno.count) - \(golesDos.count)"
            partidoEst.rival = findRival(equipoId: rival)
            partidoEst.id = partido.id
            partidoEstadisticas.append(partidoEst)
            for gol in golesUno{
                for j in jugadores{
                    if j.id == gol{
                        j.goles += 1
                    }
                }
            }
            
            if let tarjetas = partido.getTarjetas(){
                for tarjeta in tarjetas{
                    for j in jugadores{
                        if j.id == tarjeta.getId(){
                            if tarjeta.getAmarilla(){
                                j.amarillas += 1
                            }
                            else{
                                j.rojas += 1
                            }
                        }
                    }
                }
            }
        }
    }
    
    func findPuntos(resultadoUno: Int, resultadoDos: Int){
        if resultadoUno > resultadoDos{
            self.puntos += 3
        }
        else if resultadoUno == resultadoDos{
            self.puntos += 1
        }
    }
    
    func findRival(equipoId: String) -> String{
        for equipo in equipos{
            if equipo.getId() == equipoId{
                return "\(equipo.getNombre())"
            }
        }
        return ""
    }
    
    
    class JugadorEstadistica{
        var id: String = ""
        var nombre: String = ""
        var goles: Int = 0
        var amarillas: Int = 0
        var rojas: Int = 0
        
        
    }
    
    class PartidosEstadistica{
        var id: String = ""
        var fecha: String = ""
        var resultado: String = ""
        var rival: String = ""
    }
    
}
