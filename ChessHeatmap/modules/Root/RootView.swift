//
//  ThemeView.swift
//  ChessHeatmap
//
//  Created by Maxwell DeMaio on 4/16/23.
//

import SwiftUI

struct RootView: View {
    @State private var selectedTab: Tabs = .Profiles
    
    var body: some View {
        VStack {
            Text("Hello, Root View!")
                .font(.custom("KaiseiDecol-Regular", size: 32))
            NavbarView()
        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            RootView()
        }
    }
}
