//
//  ToiletsListWorkerTests.swift
//  ToiletsAppTestTests
//
//  Created by Yasin Akinci on 10/03/2024.
//

import XCTest
@testable import ToiletsAppTest

class ToiletsListWorkerTests: XCTestCase {

    let toiletsListWorker = ToiletsListWorker()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testToiletsListWorker() {
        let e = expectation(description: "fetchToiletsList")
        toiletsListWorker.fetchToiletsList(startIndex: 0) { _ in
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testToiletsListModel() {
        
        guard let path = Bundle(for: type(of: self)).path(forResource: "ToiletsList", ofType: "json") else {
            fatalError("ToiletsList.json not found") }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let response = try JSONDecoder().decode(ToiletsListCodable.self, from: data)

            XCTAssertNotNil(response, "ToiletsListCodable found")
            XCTAssertEqual(response.records?.count, 20)
        } catch {
            fatalError("ToiletsList.json file format not correct")
        }
    }

}
