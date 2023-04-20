//
//  Header.swift
//  ChessHeatmap
//
//  Created by Maxwell DeMaio on 4/20/23.
//

import SwiftUI

struct Header: View {
    var headerText: String

    var body: some View {
        Text(headerText)
            .font(.custom("KaiseiDecol-Regular", size: 32))
            .padding(.top, 34)
            .padding(.bottom, 20)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(headerText: "Hello, header text!")
    }
}
