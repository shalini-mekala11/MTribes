//
//  MTribesTests.swift
//  MTribesTests
//
//  Created by Shalini Mekala on 10/20/17.
//  Copyright © 2017 Shalini Mekala. All rights reserved.
//

import XCTest
@testable import MTribes


class CarsWebServiceTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetRemoteCars() {
        let expectation = XCTestExpectation(description: "Fetch cars")
        let service = CarsWebService()
        service.fetchCars { result in
            if let carsList = result{
                XCTAssertTrue(carsList.cars.count > 0)
                let car = carsList.cars[0]
                XCTAssertEqual(car.name, "HH-GO8522")
                XCTAssertEqual(car.exterior.rawValue, "UNACCEPTABLE")
                XCTAssertEqual(car.interior.rawValue, "UNACCEPTABLE")
                XCTAssertEqual(car.vin, "WME4513341K565439")
                XCTAssertEqual(car.location.latitude,53.59301 )
                XCTAssertEqual(car.location.longitude, 10.07526)
                expectation.fulfill()
            } else {
                XCTFail("fetching cars failed")
            }
        }
        wait(for: [expectation], timeout: 20)
    }
}

