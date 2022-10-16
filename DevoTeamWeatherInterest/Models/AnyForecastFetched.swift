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
    var message, cnt: Int?
    var weatherList: [SeveralReports]?
    var city: City?
}

// MARK: - City
struct City: Codable {
    var id: Int? = 007
    var name: String? = "¿?"
    var coord: Coord?
    var country: String? = "¿?"

    var population: Int? = 007
    var  timezone: Int? = 007
    var sunrise: Int? = 007
    var sunset: Int? = 007
}

// MARK: - Coord
struct Coord: Codable {
    var lat: Double? = 007.0
    var lon: Double? = 007.0
}

// MARK: - List
struct SeveralReports: Codable {
    var dataCalculationTime: Int? = 007
    var forecast: Details?
    var weather: [Weather]?
    var clouds: Clouds?
    var wind: Wind?
    var visibility: Int? = 007
    var pop: Double? = 007.0
    var sys: Sys?
    var dtTxt: String? = "¿?"
    var rain: Rain?

    enum CodingKeys: String, CodingKey {
        case forecast, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case dataCalculationTime = "dt"
        case rain
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    var all: Int? = 007
}

// MARK: - Details
struct Details: Codable {
    var temp: Double? = 007.0
    var feelsLike: Double? = 007.0
    var tempMin: Double? = 007.0
    var tempMax: Double? = 007.0
    var pressure: Double? = 007.0
    var seaLevel: Double? = 007.0
    var grndLevel: Double? = 007.0
    var humidity: Int? = 007
    var tempKf: Double? = 007.0

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
    var the3H: Double? = 007.0

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
    var id: Int? = 007
    var mainMeasurements: Details?
    var weatherDescription: String = "¿?"
    var icon: String? = "¿?"

    enum CodingKeys: String, CodingKey {
        case id
        case mainMeasurements = "main"

        case weatherDescription = "description"
        case icon
    }
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

// MARK: - Wind
struct Wind: Codable {
    var speed: Double? = 007.0
    var deg: Int? = 007
    var gust: Double? = 007.0
}
