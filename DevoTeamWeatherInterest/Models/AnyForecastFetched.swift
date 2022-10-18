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
//

import Foundation

// MARK: - AnyForecastFetched
struct AnyForecastFetched: Codable {
    var cod: String? = "¿?"
    var message: Int? = World.bond007Int
    var cnt: Int? = World.bond007Int
    let weatherList: [SeveralReports?]?
    let city: City?
}

// MARK: - City
struct City: Codable {
    var id: Int? = World.bond007Int
    var name: String? = "¿?"
    let coord: Coord?
    var country: String? = "¿?"

    var population: Int? = World.bond007Int
    var  timezone: Int? = World.bond007Int
    var sunrise: Int? = World.bond007Int
    var sunset: Int? = World.bond007Int
}

// MARK: - Coord
struct Coord: Codable {
    var lat: Double? = World.bond007Double
    var lon: Double? = World.bond007Double
}

// MARK: - List
struct SeveralReports: Codable {
    var dataCalculationTime: Int? = World.bond007Int
    let forecast: Details?
    let weather: [Weather?]?
    let clouds: Clouds?
    let wind: Wind?
    var visibility: Int? = World.bond007Int
    var pop: Double? = World.bond007Double
    let sys: Sys?
    var dtTxt: String? = "¿?"
    let rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dataCalculationTime = "dt"
        case forecast, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case rain
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    var all: Int? = World.bond007Int
}

// MARK: - Details
struct Details: Codable {
    var temp: Double? = World.bond007Double
    var feelsLike: Double? = World.bond007Double
    var tempMin: Double? = World.bond007Double
    var tempMax: Double? = World.bond007Double
    var pressure: Double? = World.bond007Double
    var seaLevel: Double? = World.bond007Double
    var grndLevel: Double? = World.bond007Double
    var humidity: Int? = World.bond007Int
    var tempKf: Double? = World.bond007Double

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

// MARK: - Rain
struct Rain: Codable {
    var the3H: Double? = World.bond007Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct Sys: Codable {
    var pod: Pod?
}

enum Pod: String, Codable {
    case dddd
    case nnnn
    enum CodingKeys: String, CodingKey {
        case dddd = "d"
        case nnnn = "n"
    }
}

// MARK: - Weather
struct Weather: Codable {
    var id: Int? = World.bond007Int
    let mainMeasurements: Details?
    var icon: String? = "¿?"
    var sky: String? = "¿?"
    //  "Clear", "clear sky", "Clouds", "broken clouds", "few clouds"
    // "overcast clouds", "scattered clouds", "Rain", "light ", "moderate rain"

    enum CodingKeys: String, CodingKey {
        case id
        case mainMeasurements = "main"
        case sky = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable {
    var speed: Double? = World.bond007Double
    var deg: Int? = World.bond007Int
    var gust: Double? = World.bond007Double
}
