//
//  LocalCarService.swift
//  MTribes
//
//  Created by Shalini Mekala on 10/20/17.
//  Copyright © 2017 Shalini Mekala. All rights reserved.
//

import Foundation
import RealmSwift


class CarsRealmPersistentStore: CarsPersistentStoreProtocol {
    func fetchCars(completion: @escaping (CarsList?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let realm = try! Realm()
            let carList = CarsList(cars: realm.objects(RealmCar.self).map{$0.entity})
            DispatchQueue.main.async {
                completion(carList)
            }
        }
    }
    
    func saveCars(_ carsList: CarsList, completion: @escaping (Bool) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
            let realm = try Realm()
            let cars = carsList.cars.map { RealmCar(car: $0) }
                try realm.write {
                    realm.deleteAll()
                    realm.add(cars)
                    DispatchQueue.main.async {
                        completion(true)
                    }
                }
            } catch _ {
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
        
    }
    
}
