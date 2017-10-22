//
//  CarsMapViewPresenter.swift
//  MTribes
//
//  Created by Shalini Mekala on 10/20/17.
//  Copyright © 2017 Shalini Mekala. All rights reserved.
//

import Foundation


class CarsMapViewPresenter: CarsMapViewPresenterProtocol {
    weak var mapView: CarsMapViewProtocol!
    var carsDataManager = CarsDataManager.sharedManager
    private var carAnnotations = [CarAnnotation]()

    init(view: CarsMapViewProtocol) {
        self.mapView = view
    }
    
    func onMapViewDidLoad() {
        carsDataManager.getCars {[weak self] result in
            if let weakSelf = self {
                if let carsList = result {
                    weakSelf.carAnnotations = carsList.cars.map{
                        CarAnnotation(car: $0)
                    }
                    weakSelf.mapView.showAnnotations(weakSelf.carAnnotations)
                } else {
                    weakSelf.mapView.showError()
                }
            }
        }
    }
    func didSelectAnnotation(_ annotation: CarAnnotation) {
        self.mapView.showRouteTo(annotation)
        self.mapView.removeAnnotations(self.carAnnotations.filter{$0 != annotation})
        if annotation.pickScheduledTime == nil {
            self.mapView.showSchedulePickupViewFor(annotation)
        }
    }
    
    func didDeselectAnnotation(_ annotation: CarAnnotation) {
        self.mapView.removeRouteTo(annotation)
        self.mapView.showAnnotations(self.carAnnotations)
        self.mapView.hideSchedulePickupViewFor(annotation)
    }

    func didSchedulePickupFor(_ selectedAnnotation: CarAnnotation, atTime: Date) {
        selectedAnnotation.pickScheduledTime = atTime
        self.mapView.removeAnnotations([selectedAnnotation])
        self.mapView.hideSchedulePickupViewFor(selectedAnnotation)
    }
    
    func numberOfCarAnnotations() -> Int {
        return carAnnotations.count
    }
    
    func carAnnotation(atIndex: Int) -> CarAnnotation {
        return carAnnotations[atIndex]
    }
}
