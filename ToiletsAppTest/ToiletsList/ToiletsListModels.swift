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
        let onlyPRM: Bool
        let userLatitude: Double
        let userLongitude: Double
    }
    
    struct Response {
        let toiletDetails: [ToiletDetails]
        let userLatitude: Double
        let userLongitude: Double
    }
    
    struct ToiletDetails {
        let address: String?
        let district: Int?
        let onlyPRM: String?
        let openingHour: String?
        let latitude: Double?
        let longitude: Double?
    }
    
    struct ViewModel {
        let fullAddress: String
        let openingHour: String
        let isPRM: String
        let distance: String
    }
    
}
