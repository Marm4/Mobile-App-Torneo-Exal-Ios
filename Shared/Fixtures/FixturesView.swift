import SwiftUI
import Firebase


struct FixturesView: View {
    var torneo: Torneo

    var body: some View {
            VStack {
                TitleView(text: "Fixtures")
                ScrollView {
                    VStack {
                        ForEach(torneo.getFixtures(), id: \.id) { fixture in
                           
                                ShowViewList(text: fixture.getFechaNro(), navBarTitle: "Fixtures", image: (Image(systemName: "calendar")), view: AnyView(FechaView(fixture: fixture, equipos: torneo.getEquipos())))
                            
                        }
                        Spacer()
                    }
                    Spacer()
                }

        }
    }
}
