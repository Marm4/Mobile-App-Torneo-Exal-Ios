//
//  TitleView.swift
//  Torneo Exal (iOS)
//
//  Created by Marco on 20/03/2024.
//

import SwiftUI

struct TitleView: View {
    var text:String
    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(gradient: Gradient(colors: [Color("Primary"), Color("PrimaryVariation")]), startPoint: .leading, endPoint: .trailing)
                .edgesIgnoringSafeArea(.all)
                .frame(height: 40)
            
            Text(text)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
}
