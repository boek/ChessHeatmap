//
//  ThemeView.swift
//  ChessHeatmap
//
//  Created by Maxwell DeMaio on 4/16/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    
    var body: some View {
        HStack {
            
            Button {
            } label: {
                GeometryReader { geo in
                    VStack {
                        Spacer()
                        VStack {
                            Text("Profiles")
                                .foregroundColor(.black)
                                .frame(width: 80, height: 60)
                        }
                        Spacer()
                        Rectangle()
                            .foregroundColor(.blue)
                            .frame(width: geo.size.width/2, height: 4)
                            .cornerRadius(2)
                    }.frame(width: geo.size.width, height: geo.size.height)
                }
            }
            
            Button {
            } label: {
                GeometryReader { geo in
                    VStack {
                        Spacer()
                        VStack {
                            Text("Year View")
                                .foregroundColor(.black)
                                .frame(width: 80, height: 60)
                        }
                        Spacer()
                        Rectangle()
                            .foregroundColor(.blue)
                            .frame(width: geo.size.width/2, height: 4)
                            .cornerRadius(2)
                    }.frame(width: geo.size.width, height: geo.size.height)
                }
            }
            
            Button {
            } label: {
                GeometryReader { geo in
                    VStack {
                        Spacer()
                        VStack {
                            Text("Compare Stats")
                                .foregroundColor(.black)
                                .frame(width: 80, height: 60)
                        }
                        Spacer()
                        Rectangle()
                            .foregroundColor(.blue)
                            .frame(width: geo.size.width/2, height: 4)
                            .cornerRadius(2)
                    }.frame(width: geo.size.width, height: geo.size.height)
                }
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
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
