import Foundation
import SwiftUI

class TablaGenerales{
    var torneo: Torneo
    var equipos: [Equipo]
    var fixtures: [Fixture]
    var jugadoresTabla : [JugadoresTabla] = []
    
    init(torneo: Torneo, orderBy: String) {
        self.torneo = torneo
        
        self.equipos = torneo.getEquipos()
        self.fixtures = torneo.getFixtures()
        
        for equipo in equipos{
            if let jugadores = equipo.getJugadores(){
                for j in jugadores{
                    let jugador = JugadoresTabla(image: equipo.getEscudo())
                    jugador.nombre = j.getNombre()
                    jugador.id = j.getId()
                    self.jugadoresTabla.append(jugador)
                }
            }
        }
        
        for fixture in fixtures {
            for partido in fixture.getPartidos(){
                if let golesUno = partido.getGolesEquipoUno(){
                    for jId in golesUno{
                        if let jugador = jugadoresTabla.first(where: { $0.id == jId }){
                            jugador.goles += 1
                        }
                    }
                }
                if let golesDos = partido.getGolesEquipoDos(){
                    for jId in golesDos{
                        if let jugador = jugadoresTabla.first(where: { $0.id == jId }){
                            jugador.goles += 1
                        }
                    }
                }
                if let amarillas = partido.getTarjetas(){
                    for amarilla in amarillas{
                        if let jugador = jugadoresTabla.first(where:  {$0.id == amarilla.getJugadorId()}){
                            if amarilla.getAmarilla(){
                                jugador.amarillas += 1
                            }
                            else{
                                jugador.rojas += 1
                            }
                        }
                    }
                }
                if let mvp = partido.getMvp(){
                    if let jugador = jugadoresTabla.first(where: {$0.id == mvp.getId()}){
                        jugador.mvp += 1
                    }
                }
            }
        }
        
        OrderBy(order: orderBy)
    }
    
    func OrderBy(order: String){
        if order == "goles"{
            jugadoresTabla.sort { (jugador1, jugador2) -> Bool in
                return jugador1.goles > jugador2.goles
            }
        }
        if order == "amarillas"{
            jugadoresTabla.sort { (jugador1, jugador2) -> Bool in
                return jugador1.amarillas > jugador2.amarillas
            }
        }
        
        if order == "rojas"{
            jugadoresTabla.sort { (jugador1, jugador2) -> Bool in
                return jugador1.rojas > jugador2.rojas
            }
        }
        
        if order == "mvp"{
            jugadoresTabla.sort { (jugador1, jugador2) -> Bool in
                return jugador1.mvp > jugador2.mvp
            }
        }
        
        var i = 1
        for jugador in jugadoresTabla {
            jugador.pos = i
            i+=1
        }        
    }
    
    
    
    
    class JugadoresTabla{
        var id : String = ""
        var pos : Int = 0
        var nombre : String = ""
        var escudo: Image
        var goles : Int = 0
        var amarillas: Int = 0
        var rojas: Int = 0
        var mvp : Int = 0
        
        init(image: Image?){
            if let escudo = image{
                self.escudo = escudo
            }
            else{
                self.escudo = Image(systemName: "shield.fill")
            }
        }
    }
    
}
