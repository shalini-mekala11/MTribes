//
//  CarsPersistedStoreProtocol.swift
//  MTribes
//
//  Created by Shalini Mekala on 10/20/17.
//  Copyright © 2017 Shalini Mekala. All rights reserved.
//

import Foundation

protocol CarsPersistentStoreProtocol {
    func fetchCars(completion: @escaping (CarsList?) -> Void)
    func saveCars(_ carsList: CarsList, completion: @escaping (Bool) -> Void)
}
