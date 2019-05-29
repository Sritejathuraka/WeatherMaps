//
//  FullMapViewController.swift
//  Weathertime
//
//  Created by Sriteja Thuraka on 4/24/18.
//  Copyright © 2018 Sriteja Thuraka. All rights reserved.
//

import UIKit
import MapKit
import GooglePlaces

class FullMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    var locLatitude: Double!
    var locLongitude: Double!
    var cityName: String!
    var cityTemp: Int!
    var weatherCondition: String!
    var weatherIconName: String!
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let currentData = WeatherDataManager.sharedInstance.currentData
        mapView.delegate = self
        let latitude: CLLocationDegrees = locLatitude
        let longitude: CLLocationDegrees = locLongitude
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let annotation = MKPointAnnotation()
        let locationName = CLLocation(latitude: WeatherDataManager.sharedInstance.latitude, longitude: WeatherDataManager.sharedInstance.longitude)
        CLGeocoder().reverseGeocodeLocation(locationName) { (placemarks, error) in
            if error != nil {
                return
            }else if ((currentData?.cityName = placemarks?.first?.locality) != nil) {
              self.cityName = currentData?.cityName
                annotation.title = self.cityName
            }
        }
     
        annotation.subtitle = "\(cityTemp!)°F / \(weatherCondition!)"
        annotation.coordinate = location
        self.mapView.showAnnotations([annotation], animated: true)
        self.mapView.selectAnnotation(annotation, animated: true )
        
        // Add search
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        let subView = UIView(frame: CGRect(x: 0, y: 65.0, width: 350.0, height: 45.0))
        
        subView.addSubview((searchController?.searchBar)!)
        view.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
        
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
extension FullMapViewController: GMSAutocompleteResultsViewControllerDelegate {
//    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
//        <#code#>
//    }
//    
   
 
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
