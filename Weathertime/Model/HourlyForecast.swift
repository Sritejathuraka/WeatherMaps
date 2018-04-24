//
//  HourlyForecast.swift
//  Weathertime
//
//  Created by Sriteja Thuraka on 4/18/18.
//  Copyright © 2018 Sriteja Thuraka. All rights reserved.
//

import Foundation
import Alamofire
class  HourlyForecast {
    var hourlyTime: String!
    var hourlyIcon: String!
    var hourlyTemp: String!
    
    init(hourlyWeatherDict: Dictionary<String, AnyObject>) {
        self.hourlyTemp = hourlyWeatherDict["summary"] as? String
        self.hourlyIcon = hourlyWeatherDict["icon"] as? String
        let hourlyDay = hourlyWeatherDict["time"] as? Double
        let convertDate = Date(timeIntervalSince1970: hourlyDay!)
        self.hourlyTime = convertDate.day()
    }
}
extension Date {
    func day() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: self)
    }
}
