//
//  ViewController.swift
//  MapKitTest
//
//  Created by Edgar Alexander on 14/08/2020.
//  Copyright © 2020 Edgar Alexander. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    init(pinTitle:String, pinSubtitle:String, location:CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubtitle
        self.coordinate = location
    }
}
class ViewController: UIViewController, MKMapViewDelegate {
    let miLocalizacion = CLLocation(latitude:41.3717904, longitude:2.1155786)

    let distanceSpan: CLLocationDistance = 10000
    func zoomLevel(location: CLLocation) {
        print(distanceSpan)
        let mapCoordinates = MKCoordinateRegion(center: location.coordinate,latitudinalMeters: distanceSpan,longitudinalMeters: distanceSpan)
                    mapView.setRegion(mapCoordinates, animated: true)
    }
    let localizaciones = [
    ["title": "Restaurante Lasarte","subtitle":"Restaurante 1", "latitude" : 41.393639 , "longitude": 2.162126],
    ["title": "La Tartareria Raw Food","subtitle":"Restaurante 2", "latitude" : 41.384888 , "longitude": 2.162039],
    ["title": "Jobs Restaurant BCN","subtitle":"Restaurante 3", "latitude" : 41.388524 , "longitude": 2.155976],
    ]
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var selector: UISegmentedControl!
    
    let locationManager = CLLocationManager()
 
    @IBOutlet var popUp: UIView!
    @IBAction func closePopUp(_ sender: Any) {
        animacionFinal()
    }
    private func bordes() {
        popUp.layer.cornerRadius = 18
        //pop.layer.masksToBounds = true
    }
    private func sombras(scale: Bool = true) {
        popUp.layer.shadowColor = UIColor.black.cgColor
        popUp.layer.shadowOffset = .zero
        popUp.layer.shadowOpacity = 0.2
        popUp.layer.shadowRadius = 10
        
        popUp.layer.shadowPath = UIBezierPath(rect: popUp.bounds).cgPath
        popUp.layer.shouldRasterize = true
        popUp.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    private func moveRight(view: UIView) {
        view.center.x += 300
    }
    private func moveLeft(view: UIView) {
        view.center.x -= 300
    }
    private func animacionInicial() {
        UIView.animate(withDuration: 0.5) {
            self.moveRight(view: self.popUp)
        }
    }
    private func animacionFinal() {
        UIView.animate(withDuration: 0.5,animations: {
            self.moveLeft(view: self.popUp)
        }, completion:{(finished: Bool) in
            if (finished)
            {
            }
        });
         }
    func mapView(_ mapView:MKMapView, viewFor annotation:MKAnnotation)->MKAnnotationView?
    {
        if annotation is MKUserLocation {
            return nil
        }
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customannotation")
        let rightButtom = UIButton(type: .contactAdd)
        rightButtom.tag = annotation.hash
        
        annotationView.image = UIImage(named: "pin")
        annotationView.canShowCallout = false
        annotationView.rightCalloutAccessoryView = rightButtom
        
        return annotationView
        
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
       mapView.deselectAnnotation(view.annotation, animated: true)
        self.view.addSubview(popUp)
    }
    @IBAction func cambiarVistaMapa(_ sender: Any) {
        switch selector.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            break
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bordes()
        sombras()
        animacionInicial()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true

        zoomLevel(location: miLocalizacion)

        let location = CLLocationCoordinate2D(latitude: 41.393639, longitude:2.162126)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: distanceSpan, longitudinalMeters: distanceSpan)
        self.mapView.setRegion(region, animated: true)
        let pin = customPin(pinTitle: "Restaurante Lasarte", pinSubtitle: "Restaurante de alta cocina", location: location)
        self.mapView.addAnnotation(pin)
        self.mapView.delegate = self
    }
}
