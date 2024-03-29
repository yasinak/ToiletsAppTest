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

        let viewModels: [ToiletsList.ViewModel] = response.toiletDetails.compactMap { toiletDetails in
            
            let distance = Tools.getDistance(toiletLatitude: toiletDetails.latitude ?? 0,
                                       toiletLongitude: toiletDetails.longitude ?? 0,
                                       userLatitude: response.userLatitude,
                                       userLongitude: response.userLongitude)
            let distanceDescription = getDistanceDescription(locationDistance: distance)
            return ToiletsList.ViewModel(fullAddress: "\(toiletDetails.address ?? "") \(toiletDetails.district ?? 75000)",
                                  openingHour: "Horaire d'ouverture : \(toiletDetails.openingHour ?? "")",
                                  isPMR: "Accessible pour les PMR : " + (toiletDetails.onlyPMR ?? ""),
                                  distance: distanceDescription)
            
        }
        
        viewController?.displayToiletsList(viewModels: viewModels)
    }
    
    func presentError() {
        viewController?.displayError(message: "Le téléchargement a échoué.")
    }
    
    private func getDistanceDescription(locationDistance: CLLocationDistance?) -> String {
        guard let locationDistance = locationDistance else {
            return "Nous ne disposons pas de votre localisation"
        }
        let locationDistanceMeter = locationDistance.rounded()
        if locationDistanceMeter < 1000 {
            return "Vous êtes à une distance de \(Int(locationDistanceMeter))m"
        } else {
            let locationDistanceKm = locationDistanceMeter/1000
            return "Vous êtes à une distance de \(locationDistanceKm)km"
        }
    }
    
}
