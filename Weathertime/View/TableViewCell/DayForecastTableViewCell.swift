//
//  DayForecastTableViewCell.swift
//  Weathertime
//
//  Created by Sriteja Thuraka on 4/11/18.
//  Copyright © 2018 Sriteja Thuraka. All rights reserved.
//

import UIKit
import MapKit

class DayForecastTableViewCell: UITableViewCell, CLLocationManagerDelegate {
    
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.backgroundColor = UIColor.clear
        mapView.isHidden = true
    }
    func updateMapCell(mapLatitude: Double, mapLongitude: Double ) {
        
        mapView.isHidden = false
        let latitude: CLLocationDegrees = mapLatitude
        let longitude: CLLocationDegrees = mapLongitude
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        self.mapView.addAnnotation(annotation)
        
        // Set the Zoom level
        let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 500, 500)
        self.mapView.setRegion((region), animated: false)
        
    }
    
}
