//  ----------------------------------------------------
//
//  ContentView.swift
//  Version 1.0
//
//  Unique ID:  B3F2A833-98FF-44B6-8EAE-4500D84ED93D
//
//  part of the DevoTeamWeatherInterest™ product.
//
//  Written in Swift 5.0 on macOS 12.6
//
//  https://github.com/coldpointblue
//  Created by Hugo Diaz on 12/10/22.
//
//  ----------------------------------------------------

//  ----------------------------------------------------
/*  Goal explanation:  To display a list of cities and choose one
 to see that city's current weather report details.
 Use a search field to filter the listed choices of cities.
 Display a details weather report view popup with chosen city's info.
 */
//  ----------------------------------------------------

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
