import SwiftUI

struct PerfilEquipoView: View {
    var equipo: Equipo
    var fixtures: [Fixture]
    var equipos: [Equipo]
    var perfilEquipo: PerfilEquipo
    
    init(equipo: Equipo, fixtures: [Fixture], equipos: [Equipo]) {
        self.equipo = equipo
        self.fixtures = fixtures
        self.equipos = equipos
        self.perfilEquipo = PerfilEquipo(equipo: equipo, fixtures: fixtures, equipos: equipos)
    }
    
    var body: some View {
        VStack{
            EncabezadoView(perfilEquipo: perfilEquipo)
            GolesView(perfilEquipo: perfilEquipo)
            PartidosView(perfilEquipo: perfilEquipo)
            Spacer()
        }
    }
}

private struct PartidosView: View{
    var perfilEquipo: PerfilEquipo
    var body: some View{
        GeometryReader { geometry in
            let width: CGFloat = geometry.size.width * 0.30
            
            VStack{
                HStack{
                    Text("PARTIDOS")
                        .scaleEffect(0.7)
                        .foregroundColor(Color("PrimaryVariation"))
                        .frame(width: width)
                    Text("VS")
                        .scaleEffect(0.7)
                        .foregroundColor(Color("PrimaryVariation"))
                        .frame(width: width)
                    Text("RESULTADOS")
                        .scaleEffect(0.7)
                        .foregroundColor(Color("PrimaryVariation"))
                        .frame(width: width)
                    
                    
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity, alignment: .leading)
                ScrollView{
                    VStack{
                        ForEach(perfilEquipo.partidoEstadisticas, id: \.id) { partido in
                            EstadisticaPartidoView(fecha: partido.fecha, equipo: partido.rival, resultado: partido.resultado, width: width)
                        }
    
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color("Gris"))
                    .cornerRadius(5)
                    .cornerRadius(5)
                }
                
            }.padding([.leading, .trailing], 10.0)
            
        }
    }
}

private struct EstadisticaPartidoView: View{
    var fecha: String
    var equipo: String
    var resultado: String
    var width: CGFloat
    
    var body: some View{
        HStack{
            TextViewEstadisticas(text: fecha, width: width)
            TextViewEstadisticas(text: equipo, width: width)
            HStack{
                Text(resultado)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(.vertical, 5.0)
                    .scaleEffect(0.6)
                    .frame(width: 50)
            }
            .background(Color("PrimaryVariation"))
            .cornerRadius(5)

            .frame(width: width)
            

        }.padding(.vertical, 5.0)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct TextViewEstadisticasPartido: View{
    var text: String
    var width: CGFloat
    var body : some View{
        Text(text)
            .multilineTextAlignment(.center)
            .scaleEffect(0.7)
            .foregroundColor(Color("PrimaryVariation"))
            .frame(width: width)
    }
}

private struct GolesView: View{
    var perfilEquipo: PerfilEquipo
    var body: some View{
        GeometryReader { geometry in
            let widthList: [CGFloat] = [geometry.size.width * 0.40, geometry.size.width * 0.15]
            
            VStack{
                HStack{
                    Text("JUGADORES")
                        .scaleEffect(0.7)
                        .foregroundColor(Color("PrimaryVariation"))
                        .frame(width: widthList[0], alignment: .leading)
                    Image(systemName: "circle.fill")
                        .foregroundColor(Color.black)
                        .frame(width: widthList[1])
                    Image(systemName: "circle.fill")
                        .foregroundColor(Color.yellow)
                        .frame(width: widthList[1])
                    Image(systemName: "circle.fill")
                        .foregroundColor(Color.red)
                        .frame(width: widthList[1])
                    
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity, alignment: .leading)
                ScrollView{
                    VStack{
                        
                        ForEach(perfilEquipo.jugadores, id: \.id ) { jugador in
                            ViewEstadisticasEquipo(nombre: jugador.nombre, goles: String(jugador.goles), amarillas: String(jugador.amarillas), rojas: String(jugador.rojas), widthList: widthList)
                        }
      
                        
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color("Gris"))
                    .cornerRadius(5)
                    .cornerRadius(5)
                }
                
            }.padding([.top, .leading, .trailing], 10.0)
            
        }
    }
}

private struct ViewEstadisticasEquipo: View{
    var nombre: String
    var goles: String
    var amarillas: String
    var rojas: String
    var widthList: [CGFloat]
   
    var body: some View{
        HStack{
            NombreView(text: nombre, width: widthList[0])
            TextViewEstadisticas(text: goles, width: widthList[1])
            TextViewEstadisticas(text: amarillas, width: widthList[1])
            TextViewEstadisticas(text: rojas, width: widthList[1])
            
        }.padding(.vertical, 5.0)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
}

private struct NombreView: View{
    var text: String
    var width: CGFloat
    var body : some View{
        Text(text)
            .scaleEffect(0.7)
            .foregroundColor(Color("PrimaryVariation"))
            .frame(width: width)
    }
}

private struct TextViewEstadisticas: View{
    var text: String
    var width: CGFloat
    var body : some View{
        Text(text)
            .scaleEffect(0.7)
            .foregroundColor(Color("PrimaryVariation"))
            .frame(width: width)
    }
}



private struct EncabezadoView : View{
    var perfilEquipo: PerfilEquipo
    var body: some View{
        ZStack(alignment: .top) {
            LinearGradient(gradient: Gradient(colors: [Color("Primary"), Color("PrimaryVariation")]), startPoint: .leading, endPoint: .trailing)
                .edgesIgnoringSafeArea(.all)
                .frame(height: 150)
            
            VStack{
                Text(perfilEquipo.equipo.getNombre())
                    .font(.body)
                    .padding([.leading, .bottom])
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    .foregroundColor(.white)
            
            
                HStack{
                    perfilEquipo.equipo.getEscudo()
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                    
                    HStack{
                        TextViewEquipo(puntos: String(perfilEquipo.puntos), text: "puntos")
                        TextViewEquipo(puntos: String(perfilEquipo.goles), text: "goles")
                        TextViewEquipo(puntos: String(perfilEquipo.partidos), text: "partidos")
                    }.frame(maxWidth: .infinity)
                }
                .padding(.leading, 10.0)
                .foregroundColor(Color("PrimaryVariation"))
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 80, alignment: .leading)
                .background(Color.white)
                .cornerRadius(5)
                
                
            }.padding(.horizontal)
            
            
            
        }
    }
}


private struct TextViewEquipo : View{
    var puntos: String
    var text: String
    var body: some View{
        VStack{
            Text(puntos).scaleEffect(0.7)
            Text(text).scaleEffect(0.7)
        }.padding(.horizontal)
    }
}
