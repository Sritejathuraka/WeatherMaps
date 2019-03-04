//
//  WeatherDataManager.swift
//  Weathertime
//
//  Created by Sriteja Thuraka on 4/19/18.
//  Copyright © 2018 Sriteja Thuraka. All rights reserved.
//

import Foundation

class WeatherDataManager {
    
    static let sharedInstance = WeatherDataManager()
    var latitude: Double!
    var longitude: Double!
    var privacy = ""
    var lisence = ""
    var cityName: String!
//    var privacy: Privacy!
    var currentData: CurrentWeather!
    var hourlyData = [HourlyForecast]()
    var dayForecast = [DayForecast]()
    
    
}
