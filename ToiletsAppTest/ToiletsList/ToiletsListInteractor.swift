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
//    var toiletsListCodable: ToiletsListCodable? { get set }
}

class ToiletsListInteractor: ToiletsListBusinessLogic, ToiletsListDataStore {
    
    var presenter: ToiletsListPresentationLogic?
    var worker: ToiletsListWorker = ToiletsListWorker()
    var toiletsListCodable: ToiletsListCodable?

    // MARK: Do something

    func fetchToiletsList(request: ToiletsList.Request) {
        worker.fetchToiletsList { [weak self] result in
            switch result {
            case .success(let toiletsListCodable):
                let toiletDetails = toiletsListCodable.records?.compactMap{ records in
                    ToiletsList.ToiletDetails(address: records.fields?.adresse,
                                         district: records.fields?.arrondissement,
                                         onlyPRM: records.fields?.acces_pmr,
                                         openingHour: records.fields?.horaire,
                                         latitude: records.fields?.geo_point_2d?[0],
                                         longitude: records.fields?.geo_point_2d?[1])
                }
                
                let response = ToiletsList.Response(toiletDetails: toiletDetails ?? [],
                                                    userLatitude: request.userLatitude,
                                                    userLongitude: request.userLongitude)
                self?.presenter?.presentToiletsList(response: response)
                
            case .failure(_):
                self?.presenter?.presentError()
            }
        }
    }
    
    
    
}
