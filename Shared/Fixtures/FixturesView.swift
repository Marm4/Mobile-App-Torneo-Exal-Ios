import SwiftUI
import Firebase


struct FixturesView: View {

    var torneo: Torneo
    
    var body: some View {
        VStack {
            TitleView(text: "Fixtures")
            ForEach(torneo.getFixtures(), id: \.id) { fixture in
                ShowFechaNro(fixture: fixture, torneo: torneo)
            }
            Spacer()
        }
    }
    
    }

private struct ShowFechaNro: View {
    var fixture: Fixture
    var torneo: Torneo
    
    var body: some View {
        NavigationLink(destination: FechaView(fixture: fixture, equipos: torneo.getEquipos())) { 
            HStack {
                Image(systemName: "calendar")
                    .font(.system(size: 32))
                    .padding(.leading)
                    .foregroundColor(Color("PrimaryVariation"))
                
                Text(fixture.getFechaNro())
                    .padding(.leading, 15.0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color("PrimaryVariation"))
                    .cornerRadius(5)
                    .padding([.vertical], 15)
            }
            .background(Color("Gris"))
            .padding([.horizontal, .vertical], 10)
        }
        .navigationBarTitle("Fixtures", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarTitle("Atras")
        .navigationBarHidden(true)
    }
}
