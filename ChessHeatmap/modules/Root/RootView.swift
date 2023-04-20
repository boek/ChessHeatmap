//
//  ThemeView.swift
//  ChessHeatmap
//
//  Created by Maxwell DeMaio on 4/16/23.
//

import SwiftUI

struct RootView: View {
    // Default the tab to the Profiles view
    @State private var selectedTab: Tabs = .profiles
    
    var body: some View {
        VStack {
            // Header
            if(selectedTab == .profiles) {
                Header(headerText: "Profiles")
            } else if (selectedTab == .yearView) {
                Header(headerText: "Year View")
            } else if (selectedTab == .compareStats) {
                Header(headerText: "Compare Stats")
            } else {
                Header(headerText: "Hello, root view!")
            }
            
            // Navbar
            NavbarView(selectedTab: $selectedTab)
            
            // View
            if (selectedTab == .yearView) {
                YearResultView()
                    .with(chessClient: .live)
                    .environment(\.font, Font.custom("KaiseiDecol-Regular", size: 15))
            }
            Spacer()
        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            RootView()
        }
    }
}
