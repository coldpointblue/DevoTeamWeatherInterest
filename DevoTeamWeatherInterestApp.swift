//  ----------------------------------------------------
//
//  DevoTeamWeatherInterestApp.swift
//  Version 1.0
//
//  Unique ID:  30A9D143-1D68-42FF-B340-73C174D8375B
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

@main
struct DevoTeamWeatherInterestApp: App {
    @StateObject var cityForecastsViewModel = CityChoicesVM()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cityForecastsViewModel)
        }
    }
}
