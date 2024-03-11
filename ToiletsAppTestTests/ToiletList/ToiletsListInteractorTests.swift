//
//  ToiletsListInteractorTests.swift
//  ToiletsAppTestTests
//
//  Created by Yasin Akinci on 10/03/2024.
//

import XCTest
@testable import ToiletsAppTest

class ToiletsListInteractorTests: XCTestCase {
    
    // MARK: Subject under test
    var interactor: ToiletsListInteractor!
    
    override func setUpWithError() throws {
        setupToiletsListInteractor()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: Test setup
    
    func setupToiletsListInteractor() {
        interactor = ToiletsListInteractor()
    }
    
    class ToiletsListPresentationLogicSpy: ToiletsListPresentationLogic {
        var presentToiletsListCalled = false
        var expectPresentToiletsList: XCTestExpectation?
        func presentToiletsList(response: ToiletsList.Response) {
            presentToiletsListCalled = true
        }
        
        var presentErrorCalled = false
        func presentError() {
            presentErrorCalled = true
        }
    }
    
    class ToiletsListWorkerSpy: ToiletsListWorker {
        var presentToiletsListCalled = false
        
        override func fetchToiletsList(startIndex: Int, completion: @escaping (Result<ToiletsListCodable, Error>) -> Void) {
            presentToiletsListCalled = true
            
            if startIndex >= 0 {
                let toiletsList = ToiletsListCodable(nhits: 0,
                                                     parameters: nil,
                                                     records: [])
                completion(.success(toiletsList))
            } else {
                completion(.failure(NSError(domain:"", code: 500, userInfo:nil)))
            }
        }
    }
    
    func testSuccessFetchToiletsList() {
        let presenter = ToiletsListPresentationLogicSpy()
        presenter.expectPresentToiletsList = XCTestExpectation(description: "expect present ToiletsList")
        
        let worker = ToiletsListWorkerSpy()
        interactor.presenter = presenter
        interactor.worker = worker
        let request = ToiletsList.Request(onlyPMR: true,
                                          userLatitude: 48,
                                          userLongitude: 2,
                                          index: 0)
        
        interactor.fetchToiletsList(request: request)
        
        XCTWaiter(delegate: nil).wait(for: [presenter.expectPresentToiletsList!], timeout: 1)
        XCTAssertTrue(worker.presentToiletsListCalled, "testFetchToiletsList() worker should be called")
        XCTAssertTrue(presenter.presentToiletsListCalled, "testFetchToiletsList(request:) should ask the presenter to format the result")
    }
    
    func testFailureFetchToiletsList() {
        let presenter = ToiletsListPresentationLogicSpy()
        presenter.expectPresentToiletsList = XCTestExpectation(description: "expect present ToiletsList")
        
        let worker = ToiletsListWorkerSpy()
        interactor.presenter = presenter
        interactor.worker = worker
        let request = ToiletsList.Request(onlyPMR: true,
                                          userLatitude: 48,
                                          userLongitude: 2,
                                          index: -10)
        interactor.fetchToiletsList(request: request)
        XCTWaiter(delegate: nil).wait(for: [presenter.expectPresentToiletsList!], timeout: 1)
        XCTAssertTrue(worker.presentToiletsListCalled, "testFetchToiletsList() worker should be called")
        XCTAssertTrue(presenter.presentErrorCalled, "testFetchToiletsList(request:) should ask the presenter to format the result")
        
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
