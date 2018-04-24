//
//  DayForecast.swift
//  Weathertime
//
//  Created by Sriteja Thuraka on 4/14/18.
//  Copyright © 2018 Sriteja Thuraka. All rights reserved.
//

import Foundation

class DayForecast {
    
    var weatherDay: String!
    var weatherIcon: String!
    var dayHighTemp: Double!
    var dayLowTemp: Double!
    init(dailyWeatherDict: Dictionary<String, AnyObject>) {
        self.weatherIcon = dailyWeatherDict["icon"] as? String
        if let lowTemp = dailyWeatherDict["temperatureLow"] as? Double {
            self.dayLowTemp = Double(round(lowTemp))
        }
        if let highTemp = dailyWeatherDict["temperatureHigh"] as? Double {
            self.dayHighTemp = Double(round(highTemp))
        }
        let dayWeek = dailyWeatherDict["time"] as? Double
        let convertDate = Date(timeIntervalSince1970: dayWeek!)
        self.weatherDay = convertDate.hourlyTime()
    }
}
extension Date {
    func hourlyTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
