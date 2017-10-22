//
//  CarsList.swift
//  MTribes
//
//  Created by Shalini Mekala on 10/20/17.
//  Copyright © 2017 Shalini Mekala. All rights reserved.
//

import Foundation

struct CarsList: Decodable {
    let cars: [Car]
    
    enum CodingKeys: String, CodingKey {
        case cars = "placemarks"
    }
    init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cars = try container.decode([Car].self, forKey: .cars)
    }
    
    init(cars: [Car]) {
        self.cars = cars
    }
}
