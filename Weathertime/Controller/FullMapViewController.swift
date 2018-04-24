//
//  FullMapViewController.swift
//  Weathertime
//
//  Created by Sriteja Thuraka on 4/24/18.
//  Copyright © 2018 Sriteja Thuraka. All rights reserved.
//

import UIKit
import MapKit

class FullMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    var locLatitude: Double!
    var locLongitude: Double!
    var cityName: String!
    var cityTemp: Int!
    var weatherCondition: String!
    var weatherIconName: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapView.delegate = self
        let latitude: CLLocationDegrees = locLatitude
        let longitude: CLLocationDegrees = locLongitude
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let annotation = MKPointAnnotation()
        annotation.title = cityName
        annotation.subtitle = "\(cityTemp!)°F / \(weatherCondition!)"
        annotation.coordinate = location
        self.mapView.showAnnotations([annotation], animated: true)
        self.mapView.selectAnnotation(annotation, animated: true)
        
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyMarker"
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        var annotationView: MKMarkerAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        annotationView?.glyphImage = UIImage(named: weatherIconName)
        annotationView?.markerTintColor = UIColor.orange
        return annotationView
    }
}
