//  ----------------------------------------------------
//
//  AnyForecastFetched.swift
//  Version 1.0
//
//  Unique ID:  26EA2AA3-8789-45D0-807B-D778CC08FE6A
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
/*  Goal explanation:  Model / Entity for any city.   */
//  ----------------------------------------------------

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let allCitiesFetched = try? newJSONDecoder().decode(AnyForecastFetched.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.allCitiesFetchedTask(with: url) { allCitiesFetched, response, error in
//     if let allCitiesFetched = allCitiesFetched {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - AnyForecastFetched
struct AnyForecastFetched: Codable {
    var cod: String?
    var message, cnt: Int?
    var weatherList: [WeatherList]?
    var city: City?
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.cityTask(with: url) { city, response, error in
//     if let city = city {
//       ...
//     }
//   }
//   task.resume()

// MARK: - City
struct City: Codable {
    var id: Int?
    var name: String?
    var coord: Coord?
    var country: String?
    var population, timezone, sunrise, sunset: Int?
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.coordTask(with: url) { coord, response, error in
//     if let coord = coord {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Coord
struct Coord: Codable {
    var lat, lon: Double?
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.listTask(with: url) { list, response, error in
//     if let list = list {
//       ...
//     }
//   }
//   task.resume()

// MARK: - List
struct WeatherList: Codable {
    var dataCalculationTime: Int?
    var forecast: Details?
    var weather: [Weather]?
    var clouds: Clouds?
    var wind: Wind?
    var visibility: Int?
    var pop: Double?
    var sys: Sys?
    var dtTxt: String?
    var rain: Rain?

    enum CodingKeys: String, CodingKey {
        case forecast, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case dataCalculationTime = "dt"
        case rain
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.cloudsTask(with: url) { clouds, response, error in
//     if let clouds = clouds {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Clouds
struct Clouds: Codable {
    var all: Int?
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.DetailsTask(with: url) { details, response, error in
//     if let Details = Details {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Details
struct Details: Codable {
    var temp, feelsLike, tempMin, tempMax: Double?
    var pressure, seaLevel, grndLevel, humidity: Int?
    var tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.rainTask(with: url) { rain, response, error in
//     if let rain = rain {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Rain
struct Rain: Codable {
    var the3H: Double?

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.sysTask(with: url) { sys, response, error in
//     if let sys = sys {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Sys
struct Sys: Codable {
    var pod: Pod?
}

enum Pod: String, Codable {
    case d
    // swiftlint:disable:previous identifier_name
    case n
}    // swiftlint:disable:previous identifier_name

//
// To read values from URLs:
//
//   let task = URLSession.shared.weatherTask(with: url) { weather, response, error in
//     if let weather = weather {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Weather
struct Weather: Codable {
    var id: Int?
    var allDetail: Details?
    var weatherDescription, icon: String?

    enum CodingKeys: String, CodingKey {
        case id
        case allDetail = "main"

        case weatherDescription = "description"
        case icon
    }
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.windTask(with: url) { wind, response, error in
//     if let wind = wind {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Wind
struct Wind: Codable {
    var speed: Double?
    var deg: Int?
    var gust: Double?
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL,
                                             completionHandler: @escaping (T?, URLResponse?,
                                                                           Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func allCitiesFetchedTask(with url: URL, completionHandler:
                                @escaping (AnyForecastFetched?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url,
                                completionHandler: completionHandler)
    }
}
