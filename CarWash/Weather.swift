//
//  Weather.swift
//  OpenWeatherApp
//
//  Created by Иван on 22.07.2020.
//  Copyright © 2020 Ivan Tomashevskiy. All rights reserved.
//

import Foundation

class Weather: Codable {
    
    var data: [WeatherData]
        
    struct WeatherData: Codable {
        var forecast: Forecast
        var weatherDescription: [WeatherDescription]
        var date: String?
        
        enum CodingKeys: String, CodingKey {
            case forecast = "main"
            case weatherDescription = "weather"
            case date = "dt_txt"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case data = "list"
    }

    struct Forecast: Codable {
        var temp: Float?
        var feelsLike: Float?
        var humidity: Int?
        
        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case humidity
        }
    }

    struct WeatherDescription: Codable {
        var id:Int?
        var description: String?
        var icon: String?
    }
}
