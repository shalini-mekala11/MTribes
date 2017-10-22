//
//  CarMapViewAnnotation.swift
//  MTribes
//
//  Created by Shalini Mekala on 10/20/17.
//  Copyright © 2017 Shalini Mekala. All rights reserved.
//

import Foundation
import MapKit

class CarAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var car: Car?
    var pickScheduledTime: Date? {
        didSet(newValue) {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mma"
            let timestring = formatter.string(from: pickScheduledTime!)
            let pickscheduledLabel = NSLocalizedString("PICKUP_SCHEDULED", comment: "")
            title = String(format: pickscheduledLabel, timestring)
            subtitle = nil
        }
    }
   
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
    
   convenience init(car: Car) {
       let location = CLLocationCoordinate2D(latitude: car.location.latitude, longitude: car.location.longitude)
       self.init(coordinate: location,title: car.name, subtitle: car.address)
       self.car = car
    }
}
