//
//  WeatherData.swift
//  Clima
//
//  Created by Suhyoung Eo on 2021/08/10.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
