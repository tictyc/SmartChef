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
    let request = MKLocalSearchRequest()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // refresh coordinates on location update
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
        searchKitchenStores()
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        searchKitchenStores()
    }
    
    func searchKitchenStores() {
        
        request.naturalLanguageQuery = "Kitchen Store"
        request.region = shopMap.region
    
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: {(response, error) in
            if error != nil {
                print("Error: \(error!.localizedDescription)")
            } else if response!.mapItems.count == 0 {
                    print("No stores found")
            } else {
                for item in response!.mapItems {
                    // show search responses on the map
                    
                    self.matchingStores.append(item as MKMapItem)
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    annotation.subtitle = item.phoneNumber
                    self.shopMap.addAnnotation(annotation)
                }
            }
        })
    }
}
