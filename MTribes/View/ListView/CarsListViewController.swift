//
//  CarsListViewController.swift
//  MTribes
//
//  Created by Shalini Mekala on 10/20/17.
//  Copyright © 2017 Shalini Mekala. All rights reserved.
//

import Foundation
import UIKit

class CarsListViewController:  UITableViewController {
    var presenter: CarsListViewPresenterProtocol!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CarsListViewPresenter(view: self)
        presenter.onCarsListViewDidLoad()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCars()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let carViewModel = presenter.carViewModel(atIndexPath: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "listViewCell", for: indexPath) as! CarListViewCell
        cell.setUpContentView(withViewModel: carViewModel)
        return cell
    }
    
}

extension CarsListViewController: CarsListViewProtocol {
    func refreshView() {
        tableView.reloadData()
    }
    
    func showError() {
        let title = NSLocalizedString("ERROR_TILTE", comment: "")
        let message = NSLocalizedString("ERROR_MESSAGE", comment: "")
        let okAction = NSLocalizedString("ERROR_ACTION", comment: "")
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: okAction, style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}
