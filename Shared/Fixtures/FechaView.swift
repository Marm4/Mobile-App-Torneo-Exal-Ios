import SwiftUI
import Firebase

struct FechaView: View {
    var fixture: Fixture
    var equipos: [Equipo]
    
    var body: some View {
        ZStack() {
            LinearGradient(gradient: Gradient(colors: [Color("Primary"), Color("PrimaryVariation")]), startPoint: .leading, endPoint: .trailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                
                
                ForEach(fixture.getPartidos(), id: \.id) { partido in
                    ShowPartido(partido: partido, equipos: equipos)
                }
                Spacer()
            }
            Spacer()
            
        }
        
    }
    
}


private struct ShowPartido: View{
    var partido: Partido
    var equipos: [Equipo] = []
    var equipoUno: Equipo? {
        equipos.first { equipo in
            equipo.id == partido.getEquipoUno()
        }
    }
    
    
    
    var equipoDos: Equipo? {
        equipos.first { equipo in
            equipo.id == partido.getEquipoDos()
        }
    }
    
    var body: some View{
        
        let golesUno = String(describing: partido.getGolesEquipoUno()?.count ?? 0)
        let golesDos = String(describing: partido.getGolesEquipoDos()?.count ?? 0)
        HStack {
            if let equipoUno = equipoUno {
                Text(equipoUno.getNombre())
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color("PrimaryVariation"))
                    .frame(width: 110.0)
                    .scaleEffect(0.7)
                    .multilineTextAlignment(.trailing)
                equipoUno.getEscudo()
                    .foregroundColor(Color.black)
                    .font(.system(size: 28))
                    
            }
            
            Text("\(golesUno) - \(golesDos)")
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding(.all, 10.0)
                .background(Color("PrimaryVariation"))
                .cornerRadius(5)
                .frame(width: 80.0, height: 60.0)
                .scaleEffect(0.7)
            
            if let equipoDos = equipoDos {
                equipoDos.getEscudo()
                    .foregroundColor(Color.black)
                    .font(.system(size: 32))
                Text(equipoDos.getNombre())
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color("PrimaryVariation"))
                    .multilineTextAlignment(.leading)
                    .frame(width: 110.0)
                    .scaleEffect(0.7)
            }
        }
        .background(Color.white)
        .cornerRadius(5)
        .padding([.vertical], 15)
        
    }
    
}
