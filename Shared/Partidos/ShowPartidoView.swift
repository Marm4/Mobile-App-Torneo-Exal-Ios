//
//  ShowPartidoView.swift
//  Torneo Exal (iOS)
//
//  Created by Marco on 25/03/2024.
//

import SwiftUI

struct ShowPartidoView: View {
    var partido: Partido
    var equipoUno: Equipo
    var equipoDos: Equipo
    
    
    var body: some View{
        let golesUno = String(describing: partido.getGolesEquipoUno()?.count ?? 0)
        let golesDos = String(describing: partido.getGolesEquipoDos()?.count ?? 0)
        GeometryReader { geometry in
            let widthList: [CGFloat] = [geometry.size.width * 0.30, geometry.size.width * 1, geometry.size.width * 0.13]
            
            HStack() {
                if let equipoUno = equipoUno {
                    HStack{
                        Spacer()
                        Text(equipoUno.getNombre())
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(Color("PrimaryVariation"))
                            .scaleEffect(0.7)
                            .multilineTextAlignment(.trailing)
                    }.frame(width: widthList[0])
                    equipoUno.getEscudo()
                        .foregroundColor(Color.black)
                }
                
                HStack{
                    Text("\(golesUno) - \(golesDos)")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.vertical, 5.0)
                        .scaleEffect(0.6)
                        .frame(width: widthList[2])
                }
                .background(Color("PrimaryVariation"))
                .cornerRadius(5)
                .padding(.vertical)
                

                
                if let equipoDos = equipoDos {
                    equipoDos.getEscudo()
                        .foregroundColor(Color.black)
                        
                    HStack{
                        Text(equipoDos.getNombre())
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(Color("PrimaryVariation"))
                            .multilineTextAlignment(.leading)
                            .scaleEffect(0.7)
                        Spacer()
                    }.frame(width:widthList[0])
                }
            }
            .background(Color.white)
            .cornerRadius(5)
            .frame(width:widthList[1])
            
        }
        
    }
    
}


struct ShowPartidoWithNavView: View {
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
        
        NavigationLink(destination: PartidoView(partido: partido, equipoUno: equipoUno!, equipoDos: equipoDos!)) {
            GeometryReader { geometry in
                let widthList: [CGFloat] = [geometry.size.width * 0.30, geometry.size.width * 1, geometry.size.width * 0.13]
                
                HStack() {
                    if let equipoUno = equipoUno {
                        HStack{
                            Spacer()
                            Text(equipoUno.getNombre())
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(Color("PrimaryVariation"))
                                .scaleEffect(0.7)
                                .multilineTextAlignment(.trailing)
                        }.frame(width: widthList[0])
                        equipoUno.getEscudo()
                            .foregroundColor(Color.black)
                    }
                    
                    HStack{
                        Text("\(golesUno) - \(golesDos)")
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .padding(.vertical, 5.0)
                            .scaleEffect(0.6)
                            .frame(width: widthList[2])
                    }
                    .background(Color("PrimaryVariation"))
                    .cornerRadius(5)
                    .padding(.vertical)
                    
    
                    
                    if let equipoDos = equipoDos {
                        equipoDos.getEscudo()
                            .foregroundColor(Color.black)
                            
                        HStack{
                            Text(equipoDos.getNombre())
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(Color("PrimaryVariation"))
                                .multilineTextAlignment(.leading)
                                .scaleEffect(0.7)
                            Spacer()
                        }.frame(width:widthList[0])
                    }
                }
                .background(Color.white)
                .cornerRadius(5)
                
                .frame(width:widthList[1])
                
            }
        }
        .navigationBarTitle("Partidos", displayMode: .inline)
        .navigationBarHidden(true)
        
    }
    
    
}
