//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Prince Kumar on 2019/04/10.
//  Copyright © 2019 Prince Kumar. All rights reserved.
//
import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mapView: MKMapView!
    
    override func loadView() {
        // Create a map view
        mapView = MKMapView()
        view = mapView
        
       // let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satelite"])
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let sateliteString = NSLocalizedString("Satelite", comment: "Satelite map view")
        let hybridString = NSLocalizedString("hybrid", comment: "Hybrid map view")
        let segmentedControl = UISegmentedControl(items: [standardString, sateliteString, hybridString])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController loaded its view")
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
}
