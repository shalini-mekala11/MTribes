//
//  CarServiceProtocol.swift
//  MTribes
//
//  Created by Shalini Mekala on 10/20/17.
//  Copyright © 2017 Shalini Mekala. All rights reserved.
//

import Foundation

class CarsDataManager {
    static let sharedManager = CarsDataManager()
    lazy var webService: CarsWebServiceProtocol = {
        return CarsWebService()
    }()
    
    lazy var persistentStore: CarsPersistentStoreProtocol = {
        return CarsRealmPersistentStore()
    }()
    
    private init(){
    }
    
    func getCars(completion: @escaping (CarsList?) -> Void) {
        webService.fetchCars {[weak self] result in
            if let carsList = result {
                    self?.persistentStore.saveCars(carsList, completion: {_ in
                })
                completion(carsList)
            } else {
                self?.persistentStore.fetchCars { result in
                    if let cacheList = result {
                        completion(cacheList)
                    } else {
                        completion(nil)
                    }
                }
            }
        }
        
    }
}
