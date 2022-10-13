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
protocol CitiesProtocolType {
    func downloadCityInfoList() -> AnyPublisher<AnyCityFetched, Error>
}

class CityInfoService: CitiesProtocolType {

    func downloadCityInfoList() -> AnyPublisher<AnyCityFetched, Error> {
        let debugging = World.DebugHelpers()
        let validAddress = doubleCheckWebAddress(World.forecastRequest)
        let url = URL(string: validAddress)!
        let request = URLRequest(url: url)
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .catch { error in
                return Fail(error: error).eraseToAnyPublisher()
            }.map({
                debugging.debugPrintIncomingData($0.data)
                return $0.data
            })
            .decode(type: AnyCityFetched.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

// MARK: - Network helpers.
func doubleCheckWebAddress(_ givenAddress: String) -> String {
    // In Production this would be actual verification for source address parts.
    //    print(givenAddress)
    guard let liveWebURL = URL(string: givenAddress),
          let validWebURL = URLRequest(url: liveWebURL).url?.absoluteString else {
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
