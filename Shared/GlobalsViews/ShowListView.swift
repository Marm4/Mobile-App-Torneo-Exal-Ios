//
//  ShowListView.swift
//  Torneo Exal (iOS)
//
//  Created by Marco on 31/03/2024.
//

import SwiftUI

struct ShowViewList: View {
    var text: String
    var navBarTitle : String
    var image: Image
    var view: AnyView
    
    var body: some View {
        NavigationLink(destination: view) {
            HStack {
                image
                    .font(.system(size: 27))
                    .padding(.leading)
                    .foregroundColor(Color("PrimaryVariation"))
                
                Text(text)
                    .padding(.leading, 15.0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color("PrimaryVariation"))
                    .cornerRadius(5)
                    .padding([.vertical], 15)
            }
            .background(Color("Gris"))
            .padding([.horizontal, .vertical], 10)
        }
        .navigationBarTitle(navBarTitle, displayMode: .inline)
        .navigationBarHidden(true)
    }
}
