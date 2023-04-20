//
//  ThemeView.swift
//  ChessHeatmap
//
//  Created by Maxwell DeMaio on 4/16/23.
//

import SwiftUI

// Known number of states for our views
enum Tabs: Int {
    case profiles = 0
    case yearView = 1
    case compareStats = 2
}

struct NavbarView: View {
    
    @Binding var selectedTab: Tabs
    
    var body: some View {
        HStack {
            
            Button {
                // Switch to ProfileView
                selectedTab = .profiles
            } label: {
                NavbarButton(buttonText: "Profiles", isActive: selectedTab == .profiles)
            }
            
            Button {
                // Switch to YearView
                selectedTab = .yearView
            } label: {
                NavbarButton(buttonText: "Year View", isActive: selectedTab == .yearView)
            }
            
            Button {
                // Switch to YearView
                selectedTab = .compareStats
            } label: {
                NavbarButton(buttonText: "Compare Stats", isActive: selectedTab == .compareStats)
            }
        }
        .frame(height: 82)
        .modifier(BottomBorderModifier())
        
        
    }
    
    
    struct BottomBorderModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .overlay(Rectangle().frame(height: 1).padding(.top, 5).foregroundColor(Color("sub-3")), alignment: .bottom)
        }
    }
    
    
    struct NavbarView_Previews: PreviewProvider {
        static var previews: some View {
            NavbarView(selectedTab: .constant(.profiles))
        }
    }
}
