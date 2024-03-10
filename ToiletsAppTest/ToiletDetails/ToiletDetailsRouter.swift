//
//  ToiletDetailsRouter.swift
//  ToiletsAppTest
//
//  Created by Yasin Akinci on 10/03/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol ToiletDetailsRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ToiletDetailsDataPassing {
    var dataStore: ToiletDetailsDataStore? { get }
}

class ToiletDetailsRouter: NSObject, ToiletDetailsRoutingLogic, ToiletDetailsDataPassing {
    weak var viewController: ToiletDetailsViewController?
    var dataStore: ToiletDetailsDataStore?

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

    //func navigateToSomewhere(source: ToiletDetailsViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}

    // MARK: Passing data

    //func passDataToSomewhere(source: ToiletDetailsDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
