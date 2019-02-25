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
    var privacy = "The Louisiana Purchase Exposition dollar is a commemorative coin issue in gold dated 1903. Struck in two varieties, the coins were designed by United States Bureau of the Mint Chief Engraver Charles E. Barber. The pieces were issued to commemorate the Louisiana Purchase Exposition held in 1904 in St. Louis; one variety depicted former president Thomas Jefferson, and the other, the recently assassinated president William McKinley. Although not the first American commemorative coins, they were the first in gold.Promoters of the Louisiana Purchase Exposition, originally scheduled to open in 1903, sought a commemorative coin for fundraising purposes. Congress authorized an issue in 1902, and exposition authorities, including numismatic promoter Farran Zerbe, sought to have the coin issued with two designs, to aid sales. The price for each variety was $3, the same cost whether sold as a coin, or mounted in jewelry or on a spoon.The coins did not sell well, and most were later melted down. Zerbe, who had promised to support the issue price of the coins, did not do so as prices dropped once the fair (rescheduled for 1904) closed. This drop, however, did not greatly affect Zerbe's career, as he went on to promote other commemorative coins and become president of the American Numismatic Association. The coins also recovered, regaining their issue price by 1915; they are now worth between a few hundred and several thousand dollars, depending on condition."
    var lisence = "dkjsbwbciywbcwbvbcjsdbcweuifbhcsndcv web cs hjbsdvc jsbvCISOHFBWOHVBCS HJDBCHWSDBCHJSBCSBCHSBDCJHSABDCHLS"
    var cityName: String!
//    var privacy: Privacy!
    var currentData: CurrentWeather!
    var hourlyData = [HourlyForecast]()
    var dayForecast = [DayForecast]()
    
}
