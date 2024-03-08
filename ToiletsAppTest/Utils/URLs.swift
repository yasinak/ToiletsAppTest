//
//  URLs.swift
//  TestSephora
//
//  Created by Yasin Akinci on 09/12/2019.
//  Copyright © 2024 Yasin Akinci. All rights reserved.
//

import Foundation

struct URLs {
    
    //  https://data.ratp.fr/api/records/1.0/search/?dataset=sanisettesparis2011&start=0&rows=1000
    private static let HOST = "https://data.ratp.fr"
    private static let PATH = "/api/records/1.0/search/"
    private static let TOILETS_LIST_SERVICE_PARAMETERS = "?dataset=sanisettesparis2011&start=0&rows=1000"

    static var toiletsListUrl: String{
        return HOST + PATH + TOILETS_LIST_SERVICE_PARAMETERS
    }

}
