//
//  ToiletDetailsInteractor.swift
//  ToiletsAppTest
//
//  Created by Yasin Akinci on 10/03/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ToiletDetailsBusinessLogic {
    func fetchToiletDetails(request: ToiletDetails.Request)
}

protocol ToiletDetailsDataStore {
    var address: String? { get set }
    var district: Int? { get set }
    var onlyPMR: String? { get set }
    var openingHour: String? { get set }
    var toiletLatitude: Double? { get set }
    var toiletLongitude: Double? { get set }
    var userLatitude: Double? { get set }
    var userLongitude: Double? { get set }
}

class ToiletDetailsInteractor: ToiletDetailsBusinessLogic, ToiletDetailsDataStore {
    var address: String?
    var district: Int?
    var onlyPMR: String?
    var openingHour: String?
    var toiletLatitude: Double?
    var toiletLongitude: Double?
    var userLatitude: Double?
    var userLongitude: Double?
    var presenter: ToiletDetailsPresentationLogic?


    // MARK: Fetch Toilet Details
    func fetchToiletDetails(request: ToiletDetails.Request) {
        let response = ToiletDetails.Response(address: address,
                                              district: district,
                                              onlyPMR: onlyPMR,
                                              openingHour: openingHour,
                                              toiletLatitude: toiletLatitude,
                                              toiletLongitude: toiletLongitude,
                                              userLatitude: userLatitude,
                                              userLongitude: userLongitude)
        presenter?.presentToiletDetails(response: response)
    }
}
