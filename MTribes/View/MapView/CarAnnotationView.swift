//
//  CarAnnotationView.swift
//  MTribes
//
//  Created by Shalini Mekala on 10/20/17.
//  Copyright © 2017 Shalini Mekala. All rights reserved.
//

import Foundation
import MapKit

class CarAnnotationView: MKAnnotationView  {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        canShowCallout = true
        image = carImage()
    }

    func carImage() -> UIImage? {
        if let image = UIImage(named: "car") {
            let random = arc4random_uniform(360)
            return image.imageRotatedByDegrees(degrees: CGFloat(random))
        }
        return nil
    }
}


