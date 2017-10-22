//
//  CarViewModel.swift
//  MTribes
//
//  Created by Shalini Mekala on 10/20/17.
//  Copyright © 2017 Shalini Mekala. All rights reserved.
//

import Foundation

class CarViewModel {
    let displayName: String
    let displayEngineType: String
    let displayAddress: String
    let displayFuel: String
    let displayCondition: String
    
    init(car: Car) {
        displayName = car.name
        let engineTypeLabel = NSLocalizedString("ENGINE_TYPE", comment: "")
        displayEngineType = String(format: engineTypeLabel, String(car.engineType))
        displayAddress = car.address
        let fuelLabel = NSLocalizedString("FUEL", comment: "")
        displayFuel = String(format: fuelLabel, String(car.fuel))
        let conditionLabel = NSLocalizedString("CONDITION", comment: "")
        displayCondition = String(format: conditionLabel, car.exterior.rawValue)
    }
}
