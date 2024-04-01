
import SwiftUI

struct PosicionesView: View {
    var torneo: Torneo
    var body: some View {
        GeometryReader { geometry in
            
                VStack{
                    let widthList: [CGFloat] = [geometry.size.width * 0.10, geometry.size.width * 0.35, geometry.size.width * 0.13]
                    
                    HStack(alignment: .center) {
                        TextView(width: widthList[0], text: "Pos")
                        TextView(width: widthList[1], text: "Equipo")
                        TextView(width: widthList[2], text: "PJ")
                        TextView(width: widthList[2], text: "DIF")
                        TextView(width: widthList[2], text: "PTS")
                    }
                    .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
                    .frame(height: 35.0).background(Color("Gris"))
                    
                    Divider()
                    let tablaPosiciones = TablaPosiciones(torneo: torneo)
                    ScrollView{
                        ForEach(tablaPosiciones.tablaEquipos.indices, id: \.self) { index in
                            let equipo = tablaPosiciones.tablaEquipos[index]
                            EquipoTablaView(pos: String(equipo.posicion), equipo: equipo.equipo, pj: String(equipo.partidosJugados), dif: String(equipo.diferenciaGoles), pts: String(equipo.puntos), widthList: widthList)
                            Divider()
                        }
                }
            }
        }
        
    }
    
}



