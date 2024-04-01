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
                    ShowPartidoWithNavView(partido: partido, equipos: equipos)
                }
                Spacer()
            }
            Spacer()
            
        }
    }
}
