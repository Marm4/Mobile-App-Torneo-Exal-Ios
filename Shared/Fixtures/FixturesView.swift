import SwiftUI
import Firebase


struct FixturesView: View {
    let fixtureRef = Database.database().reference().child("fixtures")
    @State private var fixtures: [Fixture] = []
    
    var body: some View {
        VStack {
            TitleView(text: "Fixtures")
            ForEach(fixtures, id: \.id) { fixture in
                ShowFechaNro(fixture: fixture)
            }
            Spacer()
        }
        .onAppear {
            devolverFixture()
        }
    }
    
    func devolverFixture() {
        fixtureRef.observeSingleEvent(of: .value) { (snapshot) in
            var fetchedFixtures: [Fixture] = []
            if snapshot.exists() {
                for fixtureSnapshot in snapshot.children {
                    if let fixtureData = (fixtureSnapshot as? DataSnapshot)?.value as? [String: Any] {
                        if let fixture = Fixture(data: fixtureData) {
                            fetchedFixtures.append(fixture)
                        }
                    }
                }
            }
            self.fixtures = fetchedFixtures
        }
    }
}

private struct ShowFechaNro:View{
    var fixture: Fixture
    
    var body: some View {
        NavigationLink(destination: FechaView(fixture: fixture)) {
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
        }.navigationBarTitle(fixture.getFechaNro(), displayMode: .inline)
        .navigationBarHidden(true)
        .navigationTitle("Atras")
        .navigationBarHidden(true)
    }
}
