//
//  ToiletsListInteractor.swift
//  ToiletsAppTest
//
//  Created by Yasin Akinci on 08/03/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ToiletsListBusinessLogic {
    func fetchToiletsList(request: ToiletsList.Request)
}

protocol ToiletsListDataStore {
    var fetchedResult: ToiletsList.Response? { get set }
    var userLatitude: Double? { get set }
    var userLongitude: Double? { get set }
}

class ToiletsListInteractor: ToiletsListBusinessLogic, ToiletsListDataStore {
    var userLatitude: Double?
    var userLongitude: Double?
    var fetchedResult: ToiletsList.Response?
    var presenter: ToiletsListPresentationLogic?
    var worker: ToiletsListWorker = ToiletsListWorker()

    // MARK: Do something

    func fetchToiletsList(request: ToiletsList.Request) {
        self.userLatitude = request.userLatitude
        self.userLongitude = request.userLongitude
        worker.fetchToiletsList(startIndex: request.index) { [weak self] result in
            switch result {
            case .success(let toiletsListCodable):
                let toiletDetails = toiletsListCodable.records?.compactMap{ records in
                    ToiletsList.ToiletDetailsResponse(address: records.fields?.adresse,
                                         district: records.fields?.arrondissement,
                                         onlyPMR: records.fields?.acces_pmr,
                                         openingHour: records.fields?.horaire,
                                         latitude: records.fields?.geo_point_2d?[0],
                                         longitude: records.fields?.geo_point_2d?[1])
                }
                
                let response = ToiletsList.Response(toiletDetails: toiletDetails ?? [],
                                                    userLatitude: request.userLatitude,
                                                    userLongitude: request.userLongitude)
                self?.fetchedResult = response
                self?.presenter?.presentToiletsList(response: response)
                
            case .failure(_):
                self?.presenter?.presentError()
            }
        }
    }
    
    
    
}
