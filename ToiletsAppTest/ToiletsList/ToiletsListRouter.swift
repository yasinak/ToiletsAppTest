//
//  ToiletsListRouter.swift
//  ToiletsAppTest
//
//  Created by Yasin Akinci on 08/03/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol ToiletsListRoutingLogic {
    func routeToToiletDetails(index: Int)
}

protocol ToiletsListDataPassing {
    var dataStore: ToiletsListDataStore? { get }
}

class ToiletsListRouter: NSObject, ToiletsListRoutingLogic, ToiletsListDataPassing {
    weak var viewController: ToiletsListViewController?
    var dataStore: ToiletsListDataStore?
    
    // MARK: Routing
    
    func routeToToiletDetails(index: Int) {
        let storyboard = UIStoryboard(name: "ToiletDetails", bundle: nil)
        
        if let destinationVC = storyboard.instantiateInitialViewController() as? ToiletDetailsViewController {
            
            var destinationDS = destinationVC.router!.dataStore!
            passDataToToiletDetails(source: dataStore!, destination: &destinationDS, index: index)
            navigateToToiletDetails(source: viewController!, destination: destinationVC)
        }
    }

    // MARK: Navigation
    
    func navigateToToiletDetails(source: ToiletsListViewController, destination: ToiletDetailsViewController) {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    func passDataToToiletDetails(source: ToiletsListDataStore, destination: inout ToiletDetailsDataStore, index: Int) {
        destination.address = source.fetchedResult?.toiletDetails[index].address
        destination.district = source.fetchedResult?.toiletDetails[index].district
        destination.onlyPMR = source.fetchedResult?.toiletDetails[index].onlyPMR
        destination.openingHour = source.fetchedResult?.toiletDetails[index].openingHour
        destination.toiletLatitude = source.fetchedResult?.toiletDetails[index].latitude
        destination.toiletLongitude = source.fetchedResult?.toiletDetails[index].longitude
        destination.userLatitude = source.userLatitude
        destination.userLongitude = source.userLongitude
    }
}
