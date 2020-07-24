//
//  WeatherTableViewCell.swift
//  OpenWeatherApp
//
//  Created by Иван on 22.07.2020.
//  Copyright © 2020 Ivan Tomashevskiy. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet private weak var dayOfWeekLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var weatherIcon: UIImageView!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var feelsLikeLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet weak var statusImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
     public func configure(with weather: Weather.WeatherData) {
        
        selectionStyle = .none
        let id = weather.weatherDescription.first?.id
        let temperature = Int(weather.forecast.temp ?? 0)
        let feelsLikeTemperature = Int(weather.forecast.feelsLike ?? 0)
        let humidity = weather.forecast.humidity ?? 0
        
        switch id {
            case 800:
                statusImg.image = UIImage(named:"check")
            case 801:
                statusImg.image = UIImage(named:"check")
            case 802:
                statusImg.image = UIImage(named:"check")
            case 803:
                statusImg.image = UIImage(named:"check")
            case 804:
                statusImg.image = UIImage(named:"check")
            default:
                statusImg.image = UIImage(named:"close")

            }
            
        dayOfWeekLabel.text = DateHelper.getDateFrom(weather.date, type: .dayOfWeek)
        dateLabel.text = DateHelper.getDateFrom(weather.date, type: .monthAndDay)
        
        temperatureLabel.text = String(format: "%d°", temperature)
        feelsLikeLabel.text = String(format: "Feels like %d°", feelsLikeTemperature)
        humidityLabel.text = String(format: "Humidity %d%%", humidity)
        
        descriptionLabel.text = weather.weatherDescription.first?.description ?? ""
        getImage(for: weather)
    }
    func analiz(with weatherId: WeatherId.WeatherData){
//            let id = weatherId.weatherDescription.first?.id
//            print(id)
    //               switch id {
    //                  case 200:
    //                       print("Сегодня будет дождь, мы не советуем вам мыть машину.")
    //
    //                  case 500:
    //                       print("Сегодня будет дождь, мы не советуем вам мыть машину.")
    //
    //                  case 501:
    //                       print("Сегодня будет дождь, мы не советуем вам мыть машину.")
    //
    //                  default:
    //                       print("ошибка")
    //
    //                       }
            
        }
    
    private func getImage(for weather: Weather.WeatherData) {
        
        if let icon = weather.weatherDescription.first?.icon {
            
            let imageUrl = String(format: "https://openweathermap.org/img/wn/%@@2x.png", icon)
            ImageManager.shared.imageForUrl(urlString: imageUrl) { (image) in
                
                if let weatherImage = image {
                    
                    self.weatherIcon.image = weatherImage
                }
            }
        }

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
