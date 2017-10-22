//
//  CarsDataSource.swift
//  MTribesTests
//
//  Created by Shalini Mekala on 10/20/17.
//  Copyright © 2017 Shalini Mekala. All rights reserved.
//

import Foundation
import XCTest
@testable import MTribes

class MockCarsWebService: CarsWebServiceProtocol {
    func fetchCars(completion: @escaping (CarsList?) -> Void) {
        let car1 = Car(name: "Ab",
                       address: "Ab1",
                       latitude: 101.0,
                       longitude: 98.1,
                       engineType: "CE",
                       exterior: "GOOD",
                       fuel: 100,
                       interior: "GOOD",
                       vin: "132")
        let car2 = Car(name: "Ab",
                       address: "Ab1",
                       latitude: 101.0,
                       longitude: 98.1,
                       engineType: "CE",
                       exterior: "GOOD",
                       fuel: 100,
                       interior: "GOOD",
                       vin: "132")
           completion(CarsList(cars: [car1,car2]))
    }
}

class MockCarsPersistentStore: CarsPersistentStoreProtocol {
    var carsList: CarsList?
    func fetchCars(completion: @escaping (CarsList?) -> Void) {
        completion(carsList)
    }
    func saveCars(_ carsList: CarsList, completion: @escaping (Bool) -> Void) {
        self.carsList = carsList
        completion(true)
    }
}

class CarsDataRepositoryTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testGetCars() {
        let manager = CarsDataManager.sharedManager
        manager.webService = MockCarsWebService()
        manager.persistentStore = MockCarsPersistentStore()
        manager.getCars {result in
            if let carsList = result {
                XCTAssertTrue(carsList.cars.count == 2)
                let car = carsList.cars[0]
                XCTAssertEqual(car.name, "Ab")
                XCTAssertEqual(car.exterior.rawValue, "GOOD")
                XCTAssertEqual(car.interior.rawValue, "GOOD")
                XCTAssertEqual(car.vin, "132")
                XCTAssertEqual(car.location.latitude, 101.0)
                XCTAssertEqual(car.location.longitude, 98.1)
                let persistedStore = manager.persistentStore as! MockCarsPersistentStore
                XCTAssertTrue(persistedStore.carsList?.cars.count == 2)
            }
            
        }
    }
}
