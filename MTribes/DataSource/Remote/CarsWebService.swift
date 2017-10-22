//
//  RemoteCarService.swift
//  MTribes
//
//  Created by Shalini Mekala on 10/20/17.
//  Copyright © 2017 Shalini Mekala. All rights reserved.
//

import Foundation
import Alamofire

class CarsWebService: CarsWebServiceProtocol {
    private let endpoint = "http://data.m-tribes.com/locations.json"
    func fetchCars(completion: @escaping (CarsList?) -> Void) {
        let url = URL(string: endpoint)!
        Alamofire.request(
            url,
            method: .get)
            .validate()
            .responseData(completionHandler: { (response) in
                guard response.result.isSuccess else {
                    completion(nil)
                    return
                }
                guard let value = response.data else{
                    completion(nil)
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let cars = try decoder.decode(CarsList.self, from: value)
                    completion(cars)
                    
                }catch _  {
                    completion(nil)
                }
                
            })
    }
}
