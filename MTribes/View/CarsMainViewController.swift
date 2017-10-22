//
//  ViewController.swift
//  MTribes
//
//  Created by Shalini Mekala on 10/19/17.
//  Copyright © 2017 Shalini Mekala. All rights reserved.
//

import UIKit

class CarsMainViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    lazy var mapViewController: CarsMapViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "mapViewController")
        return controller as! CarsMapViewController
        }()
    
    lazy var listViewController: CarsListViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "listViewController")
        return controller as! CarsListViewController
    }()
    
    enum ViewType {
        case map
        case list
    }
    
    var currentViewType: ViewType = .map
    override func viewDidLoad() {
        super.viewDidLoad()
        mapViewController.view.frame = containerView.bounds
        self.addChildViewController(mapViewController)
        containerView.addSubview(mapViewController.view)
        mapViewController.didMove(toParentViewController: self)
    }
    
    @IBAction func switchView(_ sender: UIBarButtonItem) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        let fromViewController = currentViewType == .map ? mapViewController : listViewController
        let toViewController = currentViewType == .list ? mapViewController : listViewController
        toViewController.view.frame = containerView.bounds
        self.addChildViewController(toViewController)
        fromViewController.willMove(toParentViewController: nil)
        transition(from: fromViewController,
                   to: toViewController,
                   duration: 0.4,
                   options: .transitionFlipFromLeft,
                   animations: {
                    
        }) { _ in
            self.currentViewType = self.currentViewType == .map ? .list : .map
            self.navigationItem.rightBarButtonItem?.title = self.currentViewType == .map ? NSLocalizedString("LIST_VIEW", comment: "") : NSLocalizedString("MAP_VIEW", comment: "")
            toViewController.didMove(toParentViewController: self)
            fromViewController.removeFromParentViewController()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
}

