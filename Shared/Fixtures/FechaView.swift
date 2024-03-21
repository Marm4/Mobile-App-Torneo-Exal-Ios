//
//  FechaView.swift
//  Torneo Exal (iOS)
//
//  Created by Marco on 20/03/2024.
//

import SwiftUI
import Firebase

struct FechaView: View {
    var fixture: Fixture
    let equiposRef = Database.database().reference().child("equipos")
    @State private var equipos: [Equipo] = []
    
    var body: some View {
        ZStack() {
            LinearGradient(gradient: Gradient(colors: [Color("Primary"), Color("PrimaryVariation")]), startPoint: .leading, endPoint: .trailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
            
            
                ForEach(fixture.getPartidos().map { IdentifiablePartido(partido: $0) }) { identifiablePartido in
                    ShowPartido(partido: identifiablePartido.partido, equipos: equipos)
                    Text("Hiola")
                }
                Spacer()
            }
            Spacer()
            
        }.onAppear {
            devolverEquipos()
            
        }
        
    }
    
    func devolverEquipos() {
        print("Contenido de la fixture:", fixture)
        equiposRef.observeSingleEvent(of: .value) { (snapshot) in
            var fetchedEquipos: [Equipo] = []
            if snapshot.exists() {
                for equipoSnapshot in snapshot.children {
                    if let equipoData = (equipoSnapshot as? DataSnapshot)?.value as? [String: Any] {
                        if let equipo = Equipo(data: equipoData) {
                            fetchedEquipos.append(equipo)
                            
                            print("Contenido de la equpo:", equipo)
                        }
                    }
                }
            }
            self.equipos = fetchedEquipos
        }
    }
}

struct IdentifiablePartido: Identifiable {
    let id = UUID()
    let partido: Partido
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
                           .font(.headline)
                           .fontWeight(.bold)
                           .foregroundColor(Color("PrimaryVariation"))
                           .padding(.all, 15.0)
                       /*Image(equipoUno.getEscudo() ?? "shield.fill")
                           .foregroundColor(Color.black)
                           .padding(.all, 5.0)
                           .font(.system(size: 32))*/
                   }
                   
                Text("\(golesUno) - \(golesDos)")
                       .font(.headline)
                       .fontWeight(.bold)
                       .foregroundColor(Color.white)
                       .padding(.all, 10.0)
                       .background(Color("PrimaryVariation"))
                       .cornerRadius(5)
                   
                   if let equipoDos = equipoDos {
                       /*Image(equipoDos.escudo ?? "shield.fill")
                           .foregroundColor(Color.black)
                           .padding(.all, 5.0)
                           .font(.system(size: 32))*/
                       Text(equipoDos.getNombre())
                           .font(.headline)
                           .fontWeight(.bold)
                           .foregroundColor(Color("PrimaryVariation"))
                           .padding(.all, 15.0)
                   }
               }
               .background(Color.white)
               .cornerRadius(5)
               .padding([.vertical], 15)
       
    }
    
}
