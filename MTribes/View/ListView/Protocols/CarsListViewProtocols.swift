//
//  CarsListViewProtocols.swift
//  MTribes
//
//  Created by Shalini Mekala on 10/20/17.
//  Copyright © 2017 Shalini Mekala. All rights reserved.
//

import Foundation

//TODO - show schedule view from list
protocol CarsListViewProtocol: class {
    func refreshView()
    func showError()
}

protocol CarsListViewPresenterProtocol {
    func onCarsListViewDidLoad()
    func numberOfCars() -> Int
    func carViewModel(atIndexPath: IndexPath) -> CarViewModel
}
