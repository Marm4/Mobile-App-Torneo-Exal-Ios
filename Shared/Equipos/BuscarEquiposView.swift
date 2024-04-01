import SwiftUI

struct BuscarEquiposView: View {
    var equipos: [Equipo]
    var fixtures: [Fixture]
    var body: some View {
        VStack {
            TitleView(text: "Equipos")
            ScrollView{
                VStack{
                    
                    ForEach(equipos, id: \.id) { equipo in
                        ShowViewList(text: equipo.getNombre(), navBarTitle: "Equipos", image: equipo.getEscudo(), view: AnyView(PerfilEquipoView(equipo: equipo, fixtures: fixtures, equipos: equipos)))
                    }
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

