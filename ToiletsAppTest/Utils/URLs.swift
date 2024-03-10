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
    private static let DATASET_KEY = "?dataset="
    private static let DATASET_VALUE = "sanisettesparis2011"
    private static let START_KEY = "&start="
//    private static let START_VALUE = "0"
    private static let ROW_KEY = "&rows="
    private static let ROW_VALUE = "10"
    private static let ROW_COUNT = 10
    
//    private static let TOILETS_LIST_SERVICE_PARAMETERS = "?dataset=sanisettesparis2011&rows=10&start=0&"

    static func toiletsListUrl(startIndex: Int = 0) -> String{
        let PARAMETERS = DATASET_KEY + DATASET_VALUE + START_KEY + "\(startIndex*ROW_COUNT)" + ROW_KEY + ROW_VALUE
        return HOST + PATH + PARAMETERS
        
    }

}
