//
//  WeatherId.swift
//  CarWash
//
//  Created by Иван on 22.07.2020.
//  Copyright © 2020 Ivan Tomashevskiy. All rights reserved.
//

import Foundation
class WeatherId: Codable {
    var data: [WeatherData]
    struct WeatherData: Codable {
        var weatherDescription: [WeatherDescription]
        
        enum CodingKeys: String, CodingKey {
            case weatherDescription = "weather"
        }
    }
    enum CodingKeys: String, CodingKey {
           case data = "list"
       }
    
    struct WeatherDescription: Codable {
        var id:Int?
    }
}
