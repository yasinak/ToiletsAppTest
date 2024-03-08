//
//  ToiletsListPresenter.swift
//  ToiletsAppTest
//
//  Created by Yasin Akinci on 08/03/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import CoreLocation

protocol ToiletsListPresentationLogic {
    func presentToiletsList(response: ToiletsList.Response)
    func presentError()
}

class ToiletsListPresenter: ToiletsListPresentationLogic {
    weak var viewController: ToiletsListDisplayLogic?
    
    // MARK: Present Toilets List
    
    func presentToiletsList(response: ToiletsList.Response) {
        //        var viewModels = [ToiletsList.ViewModel]()
        
        let viewModels: [ToiletsList.ViewModel] = response.toiletDetails.compactMap { toiletDetails in
            
            let distance = getDistance(toiletLatitude: toiletDetails.latitude ?? 0,
                                       toiletLongitude: toiletDetails.longitude ?? 0,
                                       userLatitude: response.userLatitude,
                                       userLongitude: response.userLongitude)
            let distanceDescription = getDistanceDescription(locationDistance: distance)
            return ToiletsList.ViewModel(fullAddress: "\(toiletDetails.address ?? "") \(toiletDetails.district ?? 75000)",
                                  openingHour: "Horaire d'ouverture : \(toiletDetails.openingHour ?? ""))",
                                  isPRM: toiletDetails.onlyPRM ?? "",
                                  distance: distanceDescription)
            
        }
        
        viewController?.displayToiletsList(viewModels: viewModels)
    }
    
    func presentError() {
        viewController?.displayError()
    }
    
    private func getDistance(toiletLatitude: Double, toiletLongitude: Double, userLatitude: Double, userLongitude: Double) -> CLLocationDistance {
        
        let userLocation = CLLocation(latitude: userLatitude, longitude: userLongitude)
        let toiletLocation = CLLocation(latitude: toiletLatitude, longitude: toiletLongitude)
        let locationDistance = toiletLocation.distance(from: userLocation)
        return locationDistance
    }
    
    private func getDistanceDescription(locationDistance: CLLocationDistance) -> String {
        let locationDistanceMeter = locationDistance.rounded()
        if locationDistanceMeter < 1000 {
            return "Vous êtes à une distance de \(Int(locationDistanceMeter))m"
        } else {
            let locationDistanceKm = locationDistanceMeter/1000
            return "Vous êtes à une distance de \(locationDistanceKm)km"
        }
    }
    
}
