//
//  CurrentWeatherDeatilsTableViewCell.swift
//  Weathertime
//
//  Created by Sriteja Thuraka on 4/18/18.
//  Copyright © 2018 Sriteja Thuraka. All rights reserved.
//

import UIKit

class CurrentWeatherDeatilsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sunriseKeyLabel: UILabel!
    @IBOutlet weak var conditionKeyLabel: UILabel!
    @IBOutlet weak var sunsetKeyLabel: UILabel!
    @IBOutlet weak var humidityKeyLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var pressureKeyLabel: UILabel!
    @IBOutlet weak var uvIndexKeyLabel: UILabel!
    @IBOutlet weak var sunRiseLabel: UILabel!
    @IBOutlet weak var windspeedKeyLabel: UILabel!
    @IBOutlet weak var sunSetLabel: UILabel!
    @IBOutlet weak var pressurelabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var uvIndexLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func updateCellConfig(currentweather: CurrentWeather ) {
        conditionLabel.text = currentweather.condition
        sunRiseLabel.text = currentweather.sunrise
        sunSetLabel.text = currentweather.sunset
        if let pressure = currentweather.pressure {
            pressurelabel.text = "\(pressure) mb"
        }
        if let humidity = currentweather.humidity {
            humidityLabel.text = "\(Double(round((humidity * 100)))) %"
        }
        if let windSpeed = currentweather.windSpeed {
            windSpeedLabel.text = "\(windSpeed) mph"
        }
        if let uvIndex = currentweather.uvIndex {
            uvIndexLabel.text = "\(uvIndex)"
        }
        conditionKeyLabel.text = "Condition :"
        sunsetKeyLabel.text = "Sunset :"
        sunriseKeyLabel.text = "Sunset :"
        pressureKeyLabel.text = "Pressure :"
        humidityKeyLabel.text = "Humidity :"
        windspeedKeyLabel.text = "WindSpeed :"
        uvIndexKeyLabel.text = "UVIndex :"
        
        
    }
    
    
}
