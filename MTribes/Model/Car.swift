//
//  Car.swift
//  MTribes
//
//  Created by Shalini Mekala on 10/19/17.
//  Copyright © 2017 Shalini Mekala. All rights reserved.
//

import Foundation
import MapKit

struct Coordinate: Decodable {
    let latitude: Double
    let longitude: Double
}

struct Car: Decodable {
    enum Condition: String,Decodable {
        case good = "GOOD"
        case unacceptable = "UNACCEPTABLE"
    }
    let name: String
    let address: String
    let location: Coordinate
    let engineType: String
    let exterior: Condition
    let fuel: Int
    let interior: Condition
    let vin: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case address
        case engineType
        case fuel
        case exterior
        case interior
        case vin
        case location = "coordinates"
    }
    init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        address = try container.decode(String.self, forKey: .address)
        engineType = try container.decode(String.self, forKey: .engineType)
        fuel = try container.decode(Int.self, forKey: .fuel)
        exterior = (try Car.Condition(rawValue: container.decode(String.self, forKey: .exterior)))!
        interior = (try Car.Condition(rawValue: container.decode(String.self, forKey: .interior)))!
        vin = try container.decode(String.self, forKey: .vin)
        let coordinates = try container.decode([Double].self, forKey: .location)
        location = Coordinate(latitude: coordinates[1], longitude: coordinates[0])
        
    }
    
    init(name: String, address: String, latitude: Double, longitude: Double, engineType: String,
         exterior: String, fuel: Int, interior: String, vin: String) {
        self.name = name
        self.address = address
        self.location = Coordinate(latitude: latitude, longitude: longitude)
        self.engineType = engineType
        self.exterior = Condition(rawValue: exterior)!
        self.interior = Condition(rawValue: interior)!
        self.fuel = fuel
        self.vin = vin
    }
}
