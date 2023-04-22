//
//  CompareStatsView.swift
//  ChessHeatmap
//
//  Created by Maxwell DeMaio on 4/21/23.
//

import SwiftUI

struct CompareStatsView: View {
    @Environment(\.chessClient) var chessClient
    @State var username1: String = ""
    @State var username2: String = ""
    @State var searching = false
    @State private var availableYears: [Int] = []
    @State private var year: Int = Calendar.current.component(.year, from: Date())
    
    private func setupAvailableYears() {
        let currentYear = Calendar.current.component(.year, from: Date())
        availableYears = Array(2007...currentYear)
    }
    
    var body: some View {
        VStack {
            HStack{
                VStack (alignment: .leading) {
                    Text("Username1")
                    TextField("username1", text: $username1)
                        .padding(10)
                        .textInputAutocapitalization(.never)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                VStack (alignment: .leading) {
                    Text("Username2")
                    TextField("username2", text: $username2)
                        .padding(10)
                        .textInputAutocapitalization(.never)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
            }.padding()
            
            HStack {
                Picker("Year", selection: $year) {
                    ForEach(availableYears, id: \.self) { year in
                        Text(String(year))
                            .tag(year)
                    }
                }
                Button("Compare") {
                    searching = true
                }.buttonStyle(.bordered)
                
            }
            .onAppear(perform: setupAvailableYears)
            .padding(.vertical, 10)
        }
        
        
    }
}

struct CompareStatsView_Previews: PreviewProvider {
    static var previews: some View {
        CompareStatsView()
    }
}
