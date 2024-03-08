//
//  ToiletsListRouter.swift
//  ToiletsAppTest
//
//  Created by Yasin Akinci on 08/03/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol ToiletsListRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ToiletsListDataPassing {
    var dataStore: ToiletsListDataStore? { get }
}

class ToiletsListRouter: NSObject, ToiletsListRoutingLogic, ToiletsListDataPassing {
    weak var viewController: ToiletsListViewController?
    var dataStore: ToiletsListDataStore?

    // MARK: Routing

    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}

    // MARK: Navigation

    //func navigateToSomewhere(source: ToiletsListViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}

    // MARK: Passing data

    //func passDataToSomewhere(source: ToiletsListDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
