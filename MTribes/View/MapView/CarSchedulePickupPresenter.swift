//
//  CarSchedulePickupPresenter.swift
//  MTribes
//
//  Created by Shalini Mekala on 10/22/17.
//  Copyright © 2017 Shalini Mekala. All rights reserved.
//

import Foundation
import UserNotifications

protocol CarSchedulePickupPresenterProtocol {
    func schedulePickup(atTime: Date)
}

class CarSchedulePickupPresenter: CarSchedulePickupPresenterProtocol {
    weak var carSchedulePickupView: CarSchedulePickupViewProtocol!
    weak var carViewModel: CarViewModel!
    
    init(view: CarSchedulePickupViewProtocol,carViewModel: CarViewModel) {
        carSchedulePickupView = view
        self.carViewModel = carViewModel
    }
    
    func schedulePickup(atTime: Date) {
        let content = UNMutableNotificationContent()
        let notificationMessage = NSLocalizedString("NOTIFICATION_MESSAGE", comment: "")
        let notificationTitle = NSLocalizedString("NOTIFICATION_TITLE", comment: "")
        content.title = notificationTitle
        content.body = String(format: notificationMessage,carViewModel.displayName , carViewModel.displayAddress)
        content.sound = UNNotificationSound.default()
        let triggerDate = Calendar.current.dateComponents([.hour,.minute,.second,], from: atTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate,
                                                    repeats: false)
        let identifier = "MtribesLocalNotification"
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
        self.carSchedulePickupView.didSchedulePickupSuccessfully(atTime: atTime)
    }
}
