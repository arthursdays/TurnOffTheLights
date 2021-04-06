//
//  ContentView.swift
//  Shared
//
//  Created by Arthur WANG on 3/4/2021.
//

import SwiftUI

struct Light {
    var status = Bool.random()
}

struct ContentView: View {
    @State
    var lights = [
        [Light(), Light(status: true), Light()],
        [Light(), Light(), Light()],
        [Light(), Light(), Light()],
    ]
    
    private let innerSpacing = 30
    
    fileprivate func toggleLight(_ row: Int, _ column: Int) {
        lights[row][column].status.toggle()
    }
    
    func updateLightStatus(column: Int ,row: Int) {
        toggleLight(row, column)
        let top = row - 1
        if (top >= 0) {
            toggleLight(top, column)
        }
        let left = column - 1
        if (left >= 0) {
            toggleLight(row, left)
        }
        let bottom = row + 1
        if (bottom < lights.count) {
            toggleLight(bottom, column)
        }
        let right = column + 1
        if (right < lights[0].count) {
            toggleLight(row, right)
        }
    }
    
    var body: some View {
        VStack(alignment: .center){
            ForEach(0..<lights.count) { row in
                HStack(alignment: .center, spacing:20.0){
                    ForEach(0..<self.lights[row].count) { col in
                        Circle()
                            .foregroundColor(self.lights[row][col]
                                                .status ? .yellow : .blue)
                            .opacity(self.lights[row][col]
                                        .status ? 0.8 : 0.5)
                            .frame(width: UIScreen.main.bounds.width / 5,
                                   height: UIScreen.main.bounds.width / 5)
                            .shadow(color: .yellow, radius: self.lights[row][col].status ? 10:0)
                            .onTapGesture {
                                self.updateLightStatus(column: col, row: row)
                            }
                    }
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
