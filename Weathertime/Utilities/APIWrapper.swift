//
//  APIWrapper.swift
//  Weathertime
//
//  Created by Sriteja Thuraka on 4/9/18.
//  Copyright © 2018 Sriteja Thuraka. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class APIWrapper: NSObject {
    
    static let sharedInstance: APIWrapper = APIWrapper()
    
    func downloadCurrentWeatherDetails(resume: @escaping DownloadComplete) {
        Alamofire.request(weatherURL).responseJSON { response in
            let result = response.result
            if let allData = result.value as? [String: Any] {
                //Current Data
                if let currentWeatherData = allData["currently"] as? [String: Any] {
                    let currentData = CurrentWeather()
                    let currenttemp = currentWeatherData["temperature"] as? Double
                    currentData.currentTemp = Double(round(currenttemp!))
                    currentData.currentSum = currentWeatherData["summary"] as? String
                    currentData.weatherIcon = currentWeatherData["icon"] as? String
                    currentData.pressure = currentWeatherData["pressure"] as? Double
                    currentData.humidity = currentWeatherData["humidity"] as? Double
                    currentData.windSpeed = currentWeatherData["windSpeed"] as? Double
                    currentData.uvIndex = currentWeatherData["uvIndex"] as? Int
                    currentData.condition = currentWeatherData["summary"] as? String
                    if let otherCurrentData = allData["daily"] as? [String: AnyObject] {
                        if let otherCurrentDetails = otherCurrentData["data"] as? [Dictionary<String, AnyObject>] {
                            
                            if let todayDate = otherCurrentDetails[0]["time"] as? Double {
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateStyle = .full
                                dateFormatter.timeStyle = .none
                                let todayDateFormt = Date(timeIntervalSince1970: todayDate)
                                currentData.dateAndTime = dateFormatter.string(from: todayDateFormt)
                                print(currentData.dateAndTime)
                            }
                            
                            if let highTemp = otherCurrentDetails[0]["temperatureHigh"] as? Double {
                                currentData.highTemp = Double(round(highTemp))
                            }
                            if let lowtemp = otherCurrentDetails[0]["temperatureLow"] as? Double {
                                currentData.lowTemp = Double(round(lowtemp))
                            }
                            if let sunRiseTime = otherCurrentDetails[0]["sunriseTime"] as? Double {
                                let sunRise = Date(timeIntervalSince1970: sunRiseTime)
                                currentData.sunrise = sunRise.setTime()
                            }
                            if let sunSetTime = otherCurrentDetails[0]["sunsetTime"] as? Double {
                                let sunSet = Date(timeIntervalSince1970: sunSetTime)
                                currentData.sunset = sunSet.setTime()
                            }
                            if let currentSummary = otherCurrentDetails[0]["summary"] as? String {
                                currentData.daySummary = currentSummary
                            }
                            
                        }
                    }
                    WeatherDataManager.sharedInstance.currentData = currentData
                }
                
                //Parse Hourly Data
                
                if let hourlyWeatherData = allData["hourly"] as? [String: AnyObject] {
                    if let hourlyData = hourlyWeatherData["data"] as? [Dictionary<String, AnyObject>] {
                        var hrlyForeCasts = [HourlyForecast]()
                        for obj in hourlyData {
                            hrlyForeCasts.append(HourlyForecast(hourlyWeatherDict: obj))
                        }
                        
                        WeatherDataManager.sharedInstance.hourlyData = hrlyForeCasts
                    }
                }
                
                // Daily Data
                
                if let dailyWeatherData = allData["daily"] as? [String: AnyObject] {
                    if let dailyData = dailyWeatherData["data"] as? [Dictionary<String, AnyObject>] {
                        print(dailyData)
                        
                        var dayForecasts = [DayForecast]()
                        for obj in dailyData {
                            dayForecasts.append(DayForecast.init(dailyWeatherDict: obj))
                        }
                        dayForecasts.remove(at: 0)
                        WeatherDataManager.sharedInstance.dayForecast = dayForecasts
                    }
                    
                }
                resume()
            }
            
            
        }
        
    }
}
extension Date {
    func setTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: self)
    }
}
