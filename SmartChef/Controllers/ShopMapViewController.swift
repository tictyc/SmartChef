//
//  ShopMapViewController.swift
//  SmartChef
//
//  Created by Student on 04.01.18.
//  Copyright © 2018 hskl. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ShopMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var shopMap: MKMapView!
    var matchingStores: [MKMapItem] = [MKMapItem]()
    
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        let userLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(userLocation, span)
        shopMap.setRegion(region, animated: true)
        self.shopMap.showsUserLocation = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shopMap.delegate = self
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        searchStores()
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        searchStores()
    }
    
    func searchStores() {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "Electronics Store"
        request.region = shopMap.region
        
        let search = MKLocalSearch(request: request)
        
        search.start(completionHandler: {(response, error) in
            if error != nil {
                print("Error while searching: \(error!.localizedDescription)")
            } else if response!.mapItems.count == 0 {
                    print("No smart home stores found")
            } else {
                for item in response!.mapItems {
                    
                    self.matchingStores.append(item as MKMapItem)
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    self.shopMap.addAnnotation(annotation)
                }
            }
        })
    }
    
}
