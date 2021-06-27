//
//  MapViewController.swift
//  CodingAssignment
//
//  Created by Rajesh on 27/06/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var citiyModel: CityModel!
    var mapview: MKMapView = {
        let mapview = MKMapView ()
        return mapview
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.mapviewSetup()
        self.addAnnotation()
    }
    
    // Mapview setup (adding constraints).
    func mapviewSetup () {
        self.view.addSubview(mapview)
        mapview.translatesAutoresizingMaskIntoConstraints = false
        mapview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    // Created annotation(point) and adding to mapview.
    func addAnnotation () {
        if let cityObj = citiyModel, let latitude = cityObj.coord?.lat, let longitude = cityObj.coord?.lon {
            let annotation = MKPointAnnotation()
            let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapview.setRegion(region, animated: true)
            annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
            let title = "\(cityObj.name ?? ""), \(cityObj.country ?? "")"
            annotation.title = title
            self.mapview.addAnnotation(annotation)
        }
    }
}

