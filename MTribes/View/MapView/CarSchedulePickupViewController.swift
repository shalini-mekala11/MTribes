//
//  CarPaymentInfoViewController.swift
//  MTribes
//
//  Created by Shalini Mekala on 10/21/17.
//  Copyright © 2017 Shalini Mekala. All rights reserved.
//

import Foundation
import UIKit

protocol CarSchedulePickupViewProtocol: class {
    func didSchedulePickupSuccessfully(atTime: Date)
}

class CarSchedulePickupViewController: UIViewController {
    var presenter: CarSchedulePickupPresenter!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var engineType: UILabel!
    @IBOutlet weak var amountPerHour: UILabel!
    @IBOutlet weak var fuel: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.backgroundColor = UIColor.white
    }
    
    var scheduleSuccessHandler: ((_ date: Date) -> Void)?
    var carViewModel: CarViewModel? {
        didSet(newValue) {
            presenter = CarSchedulePickupPresenter(view: self,carViewModel: carViewModel!)
            condition.text = carViewModel?.displayCondition
            engineType.text =  carViewModel?.displayEngineType
            let amountPaidLabel = NSLocalizedString("AMOUNT_PAID", comment: "")
            let currencyFormatter = NumberFormatter()
            currencyFormatter.numberStyle = .currency
            currencyFormatter.currencyCode = "EUR"
            let rateString = currencyFormatter.string(from: 10)
            amountPerHour.text = String(format: amountPaidLabel, rateString!)
            fuel.text = carViewModel?.displayFuel
            showCarDetailsView()
        }
    }
   
    @IBAction func schedulePickup(_ sender: UIButton) {
       self.presenter.schedulePickup(atTime: timePicker.date)
    }
    
    func showCarDetailsView() {
        timePicker.isHidden = true
        infoView.isHidden = false
        closeButton.isHidden = true
    }
    
    func showTimePicker() {
        infoView.isHidden = true
        closeButton.isHidden = false
        timePicker.isHidden = false
    }
    
    @IBAction func selectTime(_ sender: UIButton) {
       showTimePicker()
    }
    
    @IBAction func closeTimePicker(_ sender: UIButton) {
       showCarDetailsView()
    }
}

extension CarSchedulePickupViewController: CarSchedulePickupViewProtocol {
    func didSchedulePickupSuccessfully(atTime: Date) {
        if let scheduleSuccessHandler = scheduleSuccessHandler {
            scheduleSuccessHandler(atTime)
        }
    }
}
