//
//  DateHelper.swift
//  OpenWeatherApp
//
//  Created by Иван on 22.07.2020.
//  Copyright © 2020 Ivan Tomashevskiy. All rights reserved.
//

import Foundation


final class DateHelper {
    
    private static let formatter = DateFormatter()
    
    enum DateType {
        
        case dayOfWeek
        case monthAndDay
    }
    
    class func getDateFrom(_ dateString: String?, type: DateType) -> String {
        
        if let date = dateString {
            
            formatter.timeZone = TimeZone(abbreviation: "UTC")!
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let formattedDate = formatter.date(from: date)
            
            formatter.dateFormat = type == DateType.dayOfWeek ? "EEEE" : "MMM dd"
            return formatter.string(from: formattedDate ?? Date())
        }
        
        return ""
    }
}
