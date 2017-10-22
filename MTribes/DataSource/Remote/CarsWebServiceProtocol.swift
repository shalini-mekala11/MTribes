//
//  CarsWebServiceProtocol.swift
//  MTribes
//
//  Created by Shalini Mekala on 10/21/17.
//  Copyright © 2017 Shalini Mekala. All rights reserved.
//

import Foundation

protocol CarsWebServiceProtocol {
    func fetchCars(completion: @escaping (CarsList?) -> Void)
}
