//
//  ToiletsListWorker.swift
//  ToiletsAppTest
//
//  Created by Yasin Akinci on 08/03/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class ToiletsListWorker {
    
    //MARK: - Fetch Toilets List
    
    func fetchToiletsList(completion: @escaping(_ result: Result<ToiletsListCodable, Error>) -> Void) {
        //  manage URL error
        guard let url = URL(string: URLs.toiletsListUrl) else {
            return completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Bad URL"])))
        }
        //  launch the request
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let toiletsList = try JSONDecoder().decode(ToiletsListCodable.self, from: data!)
                completion(.success(toiletsList))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

}
