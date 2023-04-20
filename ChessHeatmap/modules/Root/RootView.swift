//
//  ThemeView.swift
//  ChessHeatmap
//
//  Created by Maxwell DeMaio on 4/16/23.
//

import SwiftUI

struct RootView: View {
    @State private var selection = 0
    
    var body: some View {
        Text("hello, root!")
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            RootView()
        }
    }
}
