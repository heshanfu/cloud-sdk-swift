//
//  CoffeeDetailCallToActionViewController.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 22/09/2017.
//  Copyright © 2017 Kentico Software. All rights reserved.
//

import UIKit
import MapKit

class CoffeeDetailCallToActionViewController: UIViewController {
    
    // MARK: Properties
    
    var callToAction: CallToAction?
    var cafes: [Cafe?] = []
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet weak var map: MKMapView!
    
    // MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        setMap(cafes: cafes)
        backButton.stylePinkButton()
    }
    
    // MARK: Outlet actions
    
    @IBAction func navigateBack(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK: Behaviour
    
    private func setMap(cafes: [Cafe?]) {
        var counter = 0
        
        for cafe in cafes {
            let address = "\(cafe?.street ?? "")  \(cafe?.state ?? "") \(cafe?.country ?? "")  \(cafe?.zip ?? "")"
            
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(address) { (placemarks, error) in
                guard
                    let placemarks = placemarks,
                    let location = placemarks.first?.location
                    else {
                        print("Geocoder error")
                        counter = counter + 1
                        return
                }
                
                let pinPoint = MKPointAnnotation()
                pinPoint.coordinate = location.coordinate
                pinPoint.title = cafe?.name
                self.map?.addAnnotation(pinPoint)
                
                counter = counter + 1
                
                // Set region if processing last cafe only.
                if counter == cafes.count {
                    let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta:20))
                    self.map?.setRegion(region, animated: true)
                }
            }
        }
    }
}
