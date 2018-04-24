//
//  Constants.swift
//  Weathertime
//
//  Created by Sriteja Thuraka on 4/12/18.
//  Copyright © 2018 Sriteja Thuraka. All rights reserved.
//

import Foundation

typealias DownloadComplete = () -> ()

let weatherURL = "https://api.darksky.net/forecast/ebb88e13db960d952b428f8a10253861/\(WeatherDataManager.sharedInstance.latitude!),\(WeatherDataManager.sharedInstance.longitude!)"
