
import SwiftUI

struct GeneralesView: View {
    var torneo : Torneo
    @State var jugadores : TablaGenerales
    
    init(torneo: Torneo) {
        self.torneo = torneo
        _jugadores = State(initialValue: TablaGenerales(torneo: torneo, orderBy: "goles"))
    }
    
    var body: some View {
        GeometryReader { geometry in
        VStack{
            
            let widthList: [CGFloat] = [geometry.size.width * 0.6, geometry.size.width * 0.10, geometry.size.width * 0.08]
             

            HStack(alignment: .center) {
                TextView(width: widthList[0], text: "Equipo")
                
                Button(action: {
                    self.jugadores = TablaGenerales(torneo: self.torneo, orderBy:"goles")
                }) {
                    ImageViewEstadisticas(imageName: "circle.fill", color: Color.black, width: widthList[1])
                }
                
                Button(action: {
                    self.jugadores = TablaGenerales(torneo: self.torneo, orderBy: "amarillas")
                }) {
                    ImageViewEstadisticas(imageName: "circle.fill", color: Color.yellow, width: widthList[1])
                }
                
                Button(action: {
                    self.jugadores = TablaGenerales(torneo: self.torneo, orderBy: "rojas")
                }) {
                    ImageViewEstadisticas(imageName: "circle.fill", color: Color.red, width: widthList[1])
                }
                
                Button(action: {
                    self.jugadores = TablaGenerales(torneo: self.torneo, orderBy: "mvp")
                }) {
                    ImageViewEstadisticas(imageName: "circle.fill", color: Color.green, width: widthList[1])
                }
                
            }
            .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
            .frame(height: 35.0).background(Color("Gris"))
            
            
            Divider()
            ScrollView{
                ForEach(jugadores.jugadoresTabla.indices.prefix(20), id: \.self) { index in
                    let jugador = jugadores.jugadoresTabla[index]
                    JugadorTablaView(pos: String(jugador.pos), escudo: jugador.escudo, jugador: jugador.nombre, goles: String(jugador.goles), amarillas: String(jugador.amarillas), rojas: String(jugador.rojas), mvp: String(jugador.mvp), widthList: widthList)

                    Divider()
                    
                }
            }
            
            
            
            }
        }
            
    }
    
}
