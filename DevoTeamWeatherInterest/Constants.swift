//  ----------------------------------------------------
//
//  Constants.swift
//  Version 1.0
//
//  Unique ID:  2ED17E50-21C7-46F0-BDE2-AB7EF2FB4201
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
/*  Goal explanation:  Keep prototyping constants in one place
 to alter easily. */
//  ----------------------------------------------------

import SwiftUI

#if PRODUCTION
#else
struct World {

    // UIData
    // Favourites
    var favouritesUserSet: Set<String> = []
    //    var citiesIndex: [UUID: DNBUserParsedJSON] = [:]
    //    var citiesDisplayIndex: [DNBUserParsedJSON] = []

    //    var remoteGroupDNBUsers = GroupDNBUsers(data: [])
    //    var remoteDNBUsersIndex: [String: DNBUserParsedJSON] = [:]

    // Coordinates Example
    struct StockholmCoords {
        static let lat: String = "59.353729"
        static let lon: String = "18.071998"
    }

    // Web requests
    static let forecastRequest = endpoint +
        "/data/2.5/forecast?lat=" +
        StockholmCoords.lat + "&lon=" + StockholmCoords.lon + "&appid=" +
        weatherMapKey

    static let weatherMapKey = "342624122126d3a53485bbdac2436ae3"
    static let endpoint = "https://api.openweathermap.org"

    // MARK: - Errors Info
    static let sourceURLInvalidErrorMessage: String = "\r—————— invalid URL\r"
    static let jsonNoDataErrorMessage: String = "Network Error:\n  Data\n      missing"
    static let webDataDownloadErrorMessage: String = "\r—————— data download ERROR\r"
    static let jsonErrorDecodingMessage: String = "\r—————— JSON Decoder ERROR\r"

    // MARK: - Simple text for UI titles, headers
    static let welcome = "Welcome to DevoTeam WeatherInterest"
    static let weatherHeader = "DevoTeam"
    static let encouragement = "Curious? Choose a city now to check its forecast."
    // MARK: - Debugging Helper functions
    func printWithinBodyWherever(_ someVars: Any...) -> some View {
        for beautyWithin in someVars { print("----> \(beautyWithin) <-----") }
        return EmptyView()
    }

    // MARK: - print fetched JSON data or response status code.
    struct DebugHelpers {
        func debugPrintIncomingData(_ incomingData: Data) {
            print("\r\r" + String(data: incomingData, encoding: .utf8)! +
                    "\r——————————————>>>DOWNLOADED", terminator: "\r")
        }

        func debugPrintStatusCode(_ webResponse: URLResponse) {
            print((webResponse as? HTTPURLResponse)?.statusCode as Any,
                  terminator: " <<<——— RESPONSE statusCode\r\r")
        }
    }
}
#endif

// MARK: - CORRECT call eXAMPLE
// https://api.openweathermap.org/data/2.5/forecast?lat=59.3537294&lon=18.071998&appid=342624122126d3a53485bbdac2436ae3

// Lat Long call Pieces… 59.353729, 18.071998
