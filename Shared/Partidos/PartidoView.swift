import SwiftUI

struct PartidoView: View {
    var partido: Partido
    var equipoUno: Equipo
    var equipoDos: Equipo
    var body: some View {
        VStack{
            ZStack(alignment: .top) {
                LinearGradient(gradient: Gradient(colors: [Color("Primary"), Color("PrimaryVariation")]), startPoint: .leading, endPoint: .trailing)
                    .edgesIgnoringSafeArea(.all)
                    
                
                VStack{
                    Spacer()
                    ShowPartidoView(partido: partido, equipoUno: equipoUno, equipoDos: equipoDos)
                        .padding(.top, 10)
                    
                    Text("Estadisticas")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .scaleEffect(0.7)
                }
                
            }.frame(height: 110)
            
            
            HStack{
                ScrollView {
                    VStack(alignment: .leading){
                        ShowStatsView(goles: partido.getGolesEquipoUno(), tarjetas: partido.getTarjetas(), jugadores: equipoUno.getJugadores(), left: true)
                    }
                }
                    Spacer()
                ScrollView {
                    VStack(alignment: .trailing){
                        ShowStatsView(goles: partido.getGolesEquipoDos(), tarjetas: partido.getTarjetas(), jugadores: equipoDos.getJugadores(), left: false)
                        
                    }
                }
            }
                
            Spacer()
        }
            
            
        }
    }
    

private struct ShowStatsView: View{
    var goles: [String]?
    var tarjetas: [Tarjeta]?
    var jugadores: [Jugador]?
    var left: Bool
    
    var body: some View{
        if let golesAux = goles{
            ForEach(golesAux, id: \.self) { item in
                if let jugadoresAux = jugadores{
                    if let jugador = jugadoresAux.first(where: { $0.getId() == item }) {
                        StatsView(left: left, text: jugador.getNombre(), color: Color.black)
                    }
                }
                
            }
        }
        
        if let tarjetasAux = tarjetas {
            ForEach(tarjetasAux, id: \.id) { tarjeta in
                if let jugadoresAux = jugadores{
                    if let jugador = jugadoresAux.first(where: { $0.getId() == tarjeta.getJugadorId() }) {
                        let color: Color = (tarjeta.getAmarilla()) ? .yellow : .red
                        StatsView(left: left, text: jugador.getNombre(), color: color)
                    }
                }
            }
        }
    }
}



private struct StatsView: View{
    var left: Bool
    var text: String
    var color: Color
    var body: some View{
        
        HStack{
            if left{
                Text(text)
                    .font(.body)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 30.0)
                    .frame(width: 170.0, height: 70.0)
                    .scaleEffect(0.7)
                    .foregroundColor(Color("PrimaryVariation"))
            }
            Image(systemName: "circle.fill")
                .font(.system(size: 20))
                .foregroundColor(color)
                .padding(.horizontal)
            if !left{
                Text(text)
                    .font(.body)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.trailing)
                    .padding(.trailing, 30.0)
                    .frame(width: 170.0, height: 70.0)
                    .scaleEffect(0.7)
                    .foregroundColor(Color("PrimaryVariation"))
            }
        }
        .padding(.vertical, 5.0)
        .frame(height: 70.0)
        
        
    }
    
    
}
