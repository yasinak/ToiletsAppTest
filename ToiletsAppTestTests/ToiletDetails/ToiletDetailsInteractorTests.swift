//
//  ToiletDetailsInteractorTests.swift
//  ToiletsAppTestTests
//
//  Created by Yasin Akinci on 11/03/2024.
//

import XCTest
@testable import ToiletsAppTest

class ToiletDetailsInteractorTests: XCTestCase {

    // MARK: Subject under test
    var interactor: ToiletDetailsInteractor!
    
    override func setUpWithError() throws {
        setupToiletDetailsInteractor()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: Test setup

    func setupToiletDetailsInteractor() {
        interactor = ToiletDetailsInteractor()
    }

    class ToiletDetailsPresentationLogicSpy: ToiletDetailsPresentationLogic {
        
        var presentToiletDetailsCalled = false
        var expectPresentToiletList: XCTestExpectation?
        func presentToiletDetails(response: ToiletDetails.Response) {
            presentToiletDetailsCalled = true
        }   
    }

    func testFetchToiletDetails() {
        let presenter = ToiletDetailsPresentationLogicSpy()
        presenter.expectPresentToiletList = XCTestExpectation(description: "expect present Toilet Details")
        
        interactor.presenter = presenter
        interactor.fetchToiletDetails(request: ToiletDetails.Request())

        XCTWaiter(delegate: nil).wait(for: [presenter.expectPresentToiletList!], timeout: 1)
        XCTAssertTrue(presenter.presentToiletDetailsCalled, "fetchToiletDetails() should ask the presenter to format the result")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
