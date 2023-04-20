//
//  NavbarButton.swift
//  ChessHeatmap
//
//  Created by Maxwell DeMaio on 4/19/23.
//

import SwiftUI

struct NavbarButton: View {
    var buttonText: String
    var isActive: Bool
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                VStack {
                    if isActive {
                        Text(buttonText)
                            .foregroundColor(Color("apple-blue"))
                            .frame(width: 80, height: 60)
                    } else {
                        Text(buttonText)
                            .foregroundColor(Color("text-primary"))
                            .frame(width: 80, height: 60)
                    }
                    
                }
                Spacer()
                if isActive {
                    Rectangle()
                        .foregroundColor(Color("apple-blue"))
                        .frame(width: geo.size.width/2, height: 4)
                        .cornerRadius(2)
                }
            }.frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

struct NavbarButton_Previews: PreviewProvider {
    static var previews: some View {
        NavbarButton(buttonText: "Profiles", isActive: true)
    }
}
