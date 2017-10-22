//
//  CarsMapViewController.swift
//  MTribes
//
//  Created by Shalini Mekala on 10/20/17.
//  Copyright © 2017 Shalini Mekala. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class CarsMapViewController: UIViewController {
    var presenter: CarsMapViewPresenterProtocol!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var paymentContainerview: UIView!
    var locationManager: CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager!.requestAlwaysAuthorization()
        }
        presenter = CarsMapViewPresenter(view: self)
    }
}

extension CarsMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .followWithHeading
            presenter.onMapViewDidLoad()
        }
    }
}

extension CarsMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: CarAnnotation.self) {
            var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Car")
            if annotationView == nil{
                annotationView = CarAnnotationView(annotation: annotation, reuseIdentifier: "Car")
            }
            return annotationView
        }
        return nil
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        presenter.didSelectAnnotation(view.annotation as! CarAnnotation)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        presenter.didDeselectAnnotation(view.annotation as! CarAnnotation)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        return renderer
    }

}

extension CarsMapViewController: CarsMapViewProtocol {
   
    func showError() {
        let title = NSLocalizedString("ERROR_TILTE", comment: "")
        let message = NSLocalizedString("ERROR_MESSAGE", comment: "")
        let okAction = NSLocalizedString("ERROR_ACTION", comment: "")
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: okAction, style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showAnnotations(_ annotations: [CarAnnotation]) {
        mapView.addAnnotations(annotations)
    }
    
    
    func removeAnnotations(_ annotations: [CarAnnotation]) {
        mapView.removeAnnotations(annotations)
    }
    
    func showRouteTo(_ selectedAnnotation: CarAnnotation) {
        let sourceLocation = mapView.userLocation
        let destinationLocation = selectedAnnotation.coordinate
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation.coordinate, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        let directions = MKDirections(request: directionRequest)
        directions.calculate {
            (response, error) -> Void in
            guard let response = response else {
                return
            }
            let route = response.routes[0]
            self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)
        }
    }
    
    func removeRouteTo(_ selectedAnnotation: CarAnnotation) {
        mapView.removeOverlays(mapView.overlays)
    }

    func showSchedulePickupViewFor(_ selectedAnnotation: CarAnnotation) {
        let carSchedulePickupViewController = self.childViewControllers[0] as! CarSchedulePickupViewController
        carSchedulePickupViewController.carViewModel = CarViewModel(car:selectedAnnotation.car!)
        carSchedulePickupViewController.scheduleSuccessHandler = { date in
            self.presenter.didSchedulePickupFor(selectedAnnotation, atTime: date)
            self.mapView.selectAnnotation(selectedAnnotation, animated: true)
            self.paymentContainerview.isHidden = true
        }
        self.paymentContainerview.isHidden = false
    }


    func hideSchedulePickupViewFor(_ selectedAnnotation: CarAnnotation) {
        self.paymentContainerview.isHidden = true
    }
    
}
