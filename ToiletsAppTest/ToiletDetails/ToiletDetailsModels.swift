//
//  ToiletDetailsModels.swift
//  ToiletsAppTest
//
//  Created by Yasin Akinci on 10/03/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum ToiletDetails
{
    // MARK: Use cases
    
    struct Request {
    }
    
    struct Response {
        var address: String?
        var district: Int?
        var onlyPMR: String?
        var openingHour: String?
        let toiletLatitude: Double?
        let toiletLongitude: Double?
        let userLatitude: Double?
        let userLongitude: Double?
    }
    
    struct ViewModel {
        let fullAddress: String
        let openingHour: String
        let isPMR: String
        let distance: String
    }
}
