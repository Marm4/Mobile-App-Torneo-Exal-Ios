import SwiftUI


struct ImageViewPosiciones: View{
    var width : CGFloat
    var text : String
    var image: Image
    
    var body: some View{
        HStack{
            image
            Text(text)
                .fontWeight(.bold)
                .foregroundColor(Color("PrimaryVariation"))
                .scaleEffect(0.8)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: width, alignment: .leading)
    }
}


struct ImageViewEstadisticas: View{
    var imageName: String
    var color : Color
    var width : CGFloat
    
    var body: some View{
        HStack{
            Image(systemName: imageName)
                .foregroundColor(color)
        }.foregroundColor(Color("PrimaryVariation"))
        .frame(maxWidth: width, alignment: .leading)
        .multilineTextAlignment(.leading)
        
    }
}
