//
//  RealmCar.swift
//  MTribes
//
//  Created by Shalini Mekala on 10/20/17.
//  Copyright © 2017 Shalini Mekala. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class RealmCar: Object{
    dynamic var name = ""
    dynamic var address = ""
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    dynamic var engineType = ""
    dynamic var exterior = "UNACCEPTABLE"
    dynamic var fuel = 0
    dynamic var interior = "UNACCEPTABLE"
    dynamic var vin = ""
    
    convenience init(car: Car) {
        self.init()
        name = car.name
        address = car.address
        latitude = car.location.latitude
        longitude = car.location.longitude
        engineType = car.engineType
        exterior = car.exterior.rawValue
        fuel = car.fuel
        interior = car.interior.rawValue
        vin = car.vin
    }
    
    var entity: Car {
        return Car(name: name,
                   address: address,
                   latitude: latitude,
                   longitude: longitude,
                   engineType: engineType,
                   exterior: exterior,
                   fuel: fuel,
                   interior: interior,
                   vin: vin)
    }
}
