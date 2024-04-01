import SwiftUI

struct TextView: View{
    var width : CGFloat
    var text : String
    
    var body: some View{
        Text(text)
            .fontWeight(.bold)
            .foregroundColor(Color("PrimaryVariation"))
            .frame(maxWidth: width, alignment: .leading)
            .scaleEffect(0.8)
            .multilineTextAlignment(.leading)
    }
}


struct EquipoTablaView: View{
    var pos: String
    var equipo: Equipo
    var pj: String
    var dif: String
    var pts: String
    var widthList: [CGFloat]
    
    var body: some View{
        HStack(alignment: .center){
            TextView(width: widthList[0], text: pos)
            ImageViewPosiciones(width: widthList[1], text: equipo.getNombre(), image: equipo.getEscudo())
            TextView(width: widthList[2], text: pj)
            TextView(width: widthList[2], text: dif)
            TextView(width: widthList[2], text: pts)
            
        }.padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
        .frame(height: 45.0)
        
    }
}

struct JugadorTablaView: View{
    var pos: String
    var escudo: Image
    var jugador: String
    var goles: String
    var amarillas: String
    var rojas: String
    var mvp: String
    var widthList: [CGFloat]
    
    var body: some View{
        HStack(alignment: .center){
            HStack{
                TextView(width: widthList[2], text: pos)
                escudo
                    .frame(width: widthList[2])
                TextView(width: widthList[0], text: jugador)
            }
            .frame(maxWidth: widthList[0])
            TextView(width: widthList[1], text: goles)
            TextView(width: widthList[1], text: amarillas)
            TextView(width: widthList[1], text: rojas)
            TextView(width: widthList[1], text: mvp)
            
        }.padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
        .frame(height: 45.0)
        
    }
}

