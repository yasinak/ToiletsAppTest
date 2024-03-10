//
//  ToiletsListModels.swift
//  ToiletsAppTest
//
//  Created by Yasin Akinci on 08/03/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum ToiletsList
{
    // MARK: Use cases
    
    struct Request {
        let onlyPMR: Bool
        let userLatitude: Double
        let userLongitude: Double
        let index: Int
    }
    
    struct Response {
        let toiletDetails: [ToiletDetailsResponse]
        let userLatitude: Double
        let userLongitude: Double
    }
    
    struct ToiletDetailsResponse {
        let address: String?
        let district: Int?
        let onlyPMR: String?
        let openingHour: String?
        let latitude: Double?
        let longitude: Double?
    }
    
    struct ViewModel {
        let fullAddress: String
        let openingHour: String
        let isPMR: String
        let distance: String
    }
    
}
