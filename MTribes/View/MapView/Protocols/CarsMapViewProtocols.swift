//
//  CarsMapViewProtocols.swift
//  MTribes
//
//  Created by Shalini Mekala on 10/20/17.
//  Copyright © 2017 Shalini Mekala. All rights reserved.
//

import Foundation

protocol CarsMapViewProtocol: class {
    func showAnnotations(_ annotations: [CarAnnotation])
    func removeAnnotations(_ annotations: [CarAnnotation])
    func showRouteTo(_ selectedAnnotation: CarAnnotation)
    func removeRouteTo(_ selectedAnnotation: CarAnnotation)
    func showSchedulePickupViewFor(_ selectedAnnotation: CarAnnotation)
    func hideSchedulePickupViewFor(_ selectedAnnotation: CarAnnotation)
    func showError()
}


protocol CarsMapViewPresenterProtocol {
    func onMapViewDidLoad()
    func didSelectAnnotation(_ annotation: CarAnnotation)
    func didDeselectAnnotation(_ annotation: CarAnnotation)
    func carAnnotation(atIndex: Int) -> CarAnnotation
    func numberOfCarAnnotations() -> Int
    func didSchedulePickupFor(_ selectedAnnotation: CarAnnotation, atTime: Date)
}
