//
//  OpenWeatherManager.swift
//  OpenWeatherApp
//
//  Created by Иван on 22.07.2020.
//  Copyright © 2020 Ivan Tomashevskiy. All rights reserved.
//

import UIKit

protocol WeatherDelegate {
    func didUpdateWeather(_ weatherManager: OpenWeatherManager, weather: WeatherId)
    func didFailWithError(error: Error)
}

final class OpenWeatherManager {
    
    private enum Request {
        
        static let token = "e6a1c5270312f2cc57f976cf3fe77dc6"
        static let baseUrl = "https://api.openweathermap.org/data/2.5/forecast?q=%@&appid=%@&units=%@&lang=ru"
    }
    
    static let sharedInstance = OpenWeatherManager()
    private let timeToCheckWeather = "18:00:00"
    
    var allWeather: [Weather.WeatherData] = []
    var allMainWeather: [WeatherId.WeatherData] = []
    var city: String = "Moscow"
    var units: String = "Metric"
    
    func getFiveDayForecast(completion: @escaping (Bool) -> Void) {
        
        // Set request url with reference to Request enum for easy modification
        let requestUrlString = String(format: Request.baseUrl,
                                      city,
                                      Request.token,
                                      units)
        
        guard let url = URL(string: requestUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if err != nil {
                
                completion(false)
                
            } else {
                
                let decoder = JSONDecoder()
                guard let data = data else { return }
                
                do {
                    self.allWeather = []
                    let allWeatherData = try decoder.decode(Weather.self, from: data)
                    self.allMainWeather = []
                    let allMainWeatherData = try decoder.decode(WeatherId.self, from: data)
                    
                    for weather in allWeatherData.data {
                        // Only add weather data for 5 days at *12pm*
                        if let date = weather.date?.components(separatedBy: " "),
                            date.count == 2,
                            date[1] == self.timeToCheckWeather {

                            self.allWeather.append(weather)
                        }
                    }
                    for weatherId in allMainWeatherData.data {
                            self.allMainWeather.append(weatherId)
                    }
                } catch {
                    //Failed to decode JSON
                    completion(false)
                }
                
                completion(true)
            }
                        
        }.resume()
    }
}
