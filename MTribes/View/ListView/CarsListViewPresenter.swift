//
//  CarsListViewPresenter.swift
//  MTribes
//
//  Created by Shalini Mekala on 10/20/17.
//  Copyright © 2017 Shalini Mekala. All rights reserved.
//

import Foundation

class CarsListViewPresenter: CarsListViewPresenterProtocol {
    weak var listView: CarsListViewProtocol!
    var carsDataManager = CarsDataManager.sharedManager
    private var carsList = [CarViewModel]()
    
    init(view: CarsListViewProtocol) {
        listView = view
        
    }
    func onCarsListViewDidLoad() {
        carsDataManager.getCars {[weak self] result in
            if let carsList = result {
                self?.carsList = carsList.cars.map{CarViewModel(car: $0)}
                self?.listView.refreshView()
            } else {
                self?.listView.showError()
            }
        }
    }
    
    func numberOfCars() -> Int {
        return carsList.count
    }
    
    func carViewModel(atIndexPath: IndexPath) -> CarViewModel {
        return carsList[atIndexPath.row]
    }
    
}
