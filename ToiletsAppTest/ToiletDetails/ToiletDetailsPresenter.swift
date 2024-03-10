//
//  ToiletDetailsPresenter.swift
//  ToiletsAppTest
//
//  Created by Yasin Akinci on 10/03/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import CoreLocation

protocol ToiletDetailsPresentationLogic {
    func presentToiletDetails(response: ToiletDetails.Response)
}

class ToiletDetailsPresenter: ToiletDetailsPresentationLogic {
    weak var viewController: ToiletDetailsDisplayLogic?

    // MARK: Present Toilet Details

    func presentToiletDetails(response: ToiletDetails.Response) {
        let distance = Tools.getDistance(toiletLatitude: response.toiletLatitude ?? 0,
                                   toiletLongitude: response.toiletLongitude ?? 0,
                                   userLatitude: response.userLatitude ?? 0,
                                   userLongitude: response.userLongitude ?? 0)
        let distanceDescription = getDistanceDescription(locationDistance: distance)
        let viewModel = ToiletDetails.ViewModel(fullAddress: "\(response.address ?? "") \(response.district ?? 75000)",
                                                openingHour: "Horaire d'ouverture : \(response.openingHour ?? "")",
                                                isPMR: "Accessible pour les PMR : " + (response.onlyPMR ?? ""),
                                                distance: distanceDescription)
        viewController?.displayToiletDetails(viewModel: viewModel)
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
