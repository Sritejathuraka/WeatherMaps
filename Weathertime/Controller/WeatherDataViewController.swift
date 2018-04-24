//
//  WeatherDataViewController.swift
//  Weathertime
//
//  Created by Sriteja Thuraka on 4/11/18.
//  Copyright © 2018 Sriteja Thuraka. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import MapKit


class WeatherDataViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var dateAndTimeLabel: UILabel!
    @IBOutlet var currentTempLabel: UILabel!
    @IBOutlet var highAndLowTempLabel: UILabel!
    @IBOutlet var currentSummaryLabel: UILabel!
    @IBOutlet var currentWeatherIcon: UIImageView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        headerView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.lightGray
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        mainImageView.isHidden = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    @IBAction func changeSegmented(_ sender: Any) {
        let currentData = WeatherDataManager.sharedInstance.currentData
        if let temp = currentData?.currentTemp {
            switch self.segmentedControl.selectedSegmentIndex {
            case 0:
                self.currentTempLabel.text = "\(temp)"
                if let highTemp = currentData?.highTemp {
                    if let lowtemp = currentData?.lowTemp {
                        self.highAndLowTempLabel.text = "\(highTemp) / \(lowtemp)"
                    }
                }
            case 1:
                self.currentTempLabel.text = "\(Double(round((temp - 32) * 0.5556)))"
                if let highTemp = currentData?.highTemp {
                    if let lowtemp = currentData?.lowTemp {
                        self.highAndLowTempLabel.text = "\(Double(round((highTemp - 32) * 0.5556))) / \(Double(round((lowtemp - 32) * 0.5556)))"
                    }
                }
            default:
                break
            }
        }
        self.tableView.reloadData()
    }
    
    
    @IBAction func locationButton(_ sender: Any) {
        self.locationAuthorization()
        APIWrapper.sharedInstance.downloadCurrentWeatherDetails {
            self.updateUI()
            self.lookUpCurrentLocation()
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    func locationAuthorization() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            WeatherDataManager.sharedInstance.latitude = currentLocation.coordinate.latitude
            WeatherDataManager.sharedInstance.longitude = currentLocation.coordinate.longitude
        }
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            
            locationManager.requestWhenInUseAuthorization()
        }
    }
    func lookUpCurrentLocation() {
        // Use the last reported location.
        if let lastLocation = self.locationManager.location {
            print(lastLocation.coordinate)
            let geocoder = CLGeocoder()
            
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    if let currentCityName = firstLocation?.locality {
                        WeatherDataManager.sharedInstance.cityName = currentCityName
                        self.cityNameLabel.text = currentCityName
                    }
                }
            })
        }
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showMap" {
////            let destinationController = segue.destination as! FullMapViewController
//            if let mainLat = WeatherDataManager.sharedInstance.latitude {
//                if let mainLon = WeatherDataManager.sharedInstance.longitude {
//                    if let mapCityTemp = WeatherDataManager.sharedInstance.currentData {
//                        //                    destinationController.locLatitude = mainLat
//                        //                    destinationController.locLongitude = mainLon
//                        //                    destinationController.cityName = WeatherDataManager.sharedInstance.cityName
//                        //                    destinationController.cityTemp = Int(mapCityTemp.currentTemp)
//                    }
//                }
//            }
//        }
//    }
    func updateUI () {
        let currentData = WeatherDataManager.sharedInstance.currentData
        DispatchQueue.main.async {
            if let temp = currentData?.currentTemp {
                self.currentTempLabel.text = "\(temp)"
            }
            if let summary = currentData?.currentSum {
                if let daySumaryCondition = currentData?.daySummary {
                    self.currentSummaryLabel.text = "Current weather condition is \(summary) and \(daySumaryCondition)."
                }
            }
            if let highTemp = currentData?.highTemp {
                if let lowtemp = currentData?.lowTemp {
                    self.highAndLowTempLabel.text = "\(highTemp) / \(lowtemp)"
                }
            }
            self.currentWeatherIcon.image = UIImage(named: (currentData?.weatherIcon)!)
            
            self.tableView.reloadData()
        }
        if let todayDate = currentData?.dateAndTime {
            dateAndTimeLabel.text = "Today, \(todayDate)"
        }
    }
}
extension WeatherDataViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell", for: indexPath) as? CurrentWeatherDeatilsTableViewCell
            tableView.backgroundColor = UIColor.clear
            if let currentWeather = WeatherDataManager.sharedInstance.currentData {
                cell?.updateCellConfig(currentweather: currentWeather)
            }
            return cell!
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell", for: indexPath) as? DetailedWeatherTableViewCell{
                tableView.backgroundColor = UIColor.clear
                cell.backgroundColor = UIColor.clear
                cell.collectionView.tag = indexPath.row
                cell.collectionView.dataSource = self
                cell.collectionView.reloadData()
                
                return cell
            }
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "forecastDayCell", for: indexPath) as? DayForecastTableViewCell
            tableView.backgroundColor = UIColor.clear
            cell?.backgroundColor = UIColor.clear
            cell?.collectionView.tag = indexPath.row
            cell?.collectionView.dataSource = self
            cell?.collectionView.reloadData()
            if let mapLat = WeatherDataManager.sharedInstance.latitude {
                if let mapLong = WeatherDataManager.sharedInstance.longitude {
                    cell?.updateMapCell(mapLatitude: mapLat , mapLongitude: mapLong)
                }
            }
            return cell!
        default:
            fatalError("Failed to instantiate the tableview")
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 165
        case 1:
            return 86
        case 2:
            return 180
        default:
            fatalError("Failed to instantiate the tableview")
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
extension WeatherDataViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return WeatherDataManager.sharedInstance.hourlyData.count
        }else if collectionView.tag == 2 {
            return WeatherDataManager.sharedInstance.dayForecast.count
        }
        else {
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourlyCell", for: indexPath) as! forecastCollectionViewCell
            cell.backgroundColor = UIColor.clear
            let hourlyData = WeatherDataManager.sharedInstance.hourlyData
            cell.timeLabel.text = hourlyData[indexPath.row].hourlyTime
            cell.tempLabel.text = hourlyData[indexPath.row].hourlyTemp
            cell.iconImage.image = UIImage(named: hourlyData[indexPath.row].hourlyIcon)
            return cell
        }
        else if collectionView.tag == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dailyCell", for: indexPath) as? ForecastDayCollectionViewCell
            cell?.backgroundColor = UIColor.clear
            let dailyData = WeatherDataManager.sharedInstance.dayForecast
            cell?.foreCastDay.text = dailyData[indexPath.row].weatherDay
            cell?.foreCastDayImage.image = UIImage(named: dailyData[indexPath.row].weatherIcon)
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                if let dayHigh = dailyData[indexPath.row].dayHighTemp {
                    if let dayLow = dailyData[indexPath.row].dayLowTemp {
                        cell?.foreCastIcon.text = "\(dayHigh) / \(dayLow)"
                    }
                }
            case 1:
                if let dayHigh = dailyData[indexPath.row].dayHighTemp {
                    if let dayLow = dailyData[indexPath.row].dayLowTemp {
                        cell?.foreCastIcon.text = "\(Double(round((dayHigh - 32) * 0.5556))) / \(Double(round((dayLow - 32) * 0.5556)))"
                    }
                }
            default:
                break
            }
            return cell!
        } else {
            return UICollectionViewCell()
            
        }
    }
}
extension UINavigationController {
    open override var childViewControllerForStatusBarStyle: UIViewController? {
        return topViewController
    }
}


