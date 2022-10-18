//  ----------------------------------------------------
//
//  NetworkAsyncService.swift
//  Version 1.0
//
//  Unique ID:  C9CEEE2D-4956-44FE-A949-DD6D342A244C
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
//  ----------------------------------------------------
/*  Goal explanation:  Fetch city weather JSON to automatically
 update UI using Combine.   */
//  ----------------------------------------------------

import Foundation
import Combine

// MARK: - Combine Network Service to download city weather JSON data.

protocol AnyCityWeather {
    func downloadCityWeather() -> AnyPublisher<AnyForecastFetched, Error>
}

class CityWeather: AnyCityWeather {

    func downloadCityWeather() -> AnyPublisher<AnyForecastFetched, Error> {

        #if PRODUCTION
        #else
        let debugging = World.DebugHelpers()
        #endif

        let validAddress = doubleCheckWebAddress(World.forecastRequest)
        let url = URL(string: validAddress)!
        let request = URLRequest(url: url)

        return URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .catch { error in
                return Fail(error: error).eraseToAnyPublisher()
            }.map({

                #if PRODUCTION
                #else
                debugging.debugPrintIncomingData($0.data)
                #endif
                return $0.data
            })
            .decode(type: AnyForecastFetched.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

// MARK: - Network helpers.
func doubleCheckWebAddress(_ uncheckedURL: String) -> String {
    // In Production this would be actual verification for source address parts.
    //    print(givenAddress)
    guard let currentWebURL = URL(string: uncheckedURL),
          let validWebURL = URLRequest(url: currentWebURL).url?.absoluteString else {
        return ""
    }
    return validWebURL
}

#if PRODUCTION
#else
// MARK: - Debugging helpers to print fetched JSON data or response status code.
private func debugPrintIncomingData(_ incomingData: Data) {
    print("\r\r" + String(data: incomingData, encoding: .utf8)! +
            "\r——————————————>>>DOWNLOADED", terminator: "\r")
}

private func debugPrintStatusCode(_ webResponse: URLResponse) {
    print((webResponse as? HTTPURLResponse)?.statusCode as Any,
          terminator: " <<<——— RESPONSE statusCode\r\r")
}
#endif
