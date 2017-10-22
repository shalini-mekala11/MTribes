//
//  PersistedCarsDataSourceTests.swift
//  MTribesTests
//
//  Created by Shalini Mekala on 10/20/17.
//  Copyright © 2017 Shalini Mekala. All rights reserved.
//

import Foundation
import XCTest
@testable import MTribes


class CarsPersistentStoreTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSaveCars() {
        let expectation = XCTestExpectation(description: "Save cars")
        let persistentStore = CarsRealmPersistentStore()
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
        persistentStore.saveCars(CarsList(cars: [car1,car2]),completion: { success in
            if success {
                persistentStore.fetchCars(completion:{ result in
                    if let carsList = result {
                        XCTAssertTrue(carsList.cars.count > 0)
                        let car = carsList.cars[0]
                        XCTAssertEqual(car.name, "Ab")
                        XCTAssertEqual(car.exterior.rawValue, "GOOD")
                        XCTAssertEqual(car.interior.rawValue, "GOOD")
                        XCTAssertEqual(car.vin, "132")
                        XCTAssertEqual(car.location.latitude, 101.0)
                        XCTAssertEqual(car.location.longitude, 98.1)
                        expectation.fulfill()
                    }
                })
            }
        })
        wait(for: [expectation], timeout: 20)
    }
    
   
}

