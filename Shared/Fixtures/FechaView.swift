import SwiftUI
import Firebase

struct FechaView: View {
    var fixture: Fixture
    var equipos: [Equipo]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
           
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack{
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundColor(Color("Primary"))
                    .font(.system(size: 10))
                    .padding(.leading, 10)
                    Text("Fixtures")
                        .foregroundColor(Color("Primary"))
                }.frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .frame(maxWidth: .infinity, maxHeight: 27, alignment: .leading)
            
            
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("Primary"), Color("PrimaryVariation")]), startPoint: .leading, endPoint: .trailing)
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack {
                        ForEach(fixture.getPartidos(), id: \.id) { partido in
                            ShowPartidoWithNavView(partido: partido, equipos: equipos)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                Spacer()
            }
        }
    }
}
