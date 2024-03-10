//
//  Tools.swift
//  ToiletsAppTest
//
//  Created by Yasin Akinci on 10/03/2024.
//

import Foundation
import CoreLocation

struct Tools {
    
    static func getDistance(toiletLatitude: Double, toiletLongitude: Double, userLatitude: Double, userLongitude: Double) -> CLLocationDistance? {
        //  if we don't have the localisation of the user
        guard userLatitude != 0 && userLongitude != 0 else {
            return nil
        }
        
        let userLocation = CLLocation(latitude: userLatitude, longitude: userLongitude)
        let toiletLocation = CLLocation(latitude: toiletLatitude, longitude: toiletLongitude)
        let locationDistance = toiletLocation.distance(from: userLocation)
        return locationDistance
    }
    
}
