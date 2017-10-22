//
//  CarListViewCell.swift
//  MTribes
//
//  Created by Shalini Mekala on 10/20/17.
//  Copyright © 2017 Shalini Mekala. All rights reserved.
//

import Foundation
import UIKit

class CarListViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var fuel: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var engineType: UILabel!
    
    func setUpContentView(withViewModel: CarViewModel) {
        self.name.text = withViewModel.displayName
        self.fuel.text = withViewModel.displayFuel
        self.condition.text = withViewModel.displayCondition
        self.address.text = withViewModel.displayAddress
        self.engineType.text = withViewModel.displayEngineType
        
    }
}
