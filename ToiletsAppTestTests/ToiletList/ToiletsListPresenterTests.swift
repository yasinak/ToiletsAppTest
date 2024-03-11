//
//  ToiletsListPresenterTests.swift
//  ToiletsAppTestTests
//
//  Created by Yasin Akinci on 10/03/2024.
//

import XCTest
@testable import ToiletsAppTest

class ToiletsListPresenterTests: XCTestCase {

    // MARK: Subject under test

    var sut: ToiletsListPresenter!
    
    override func setUpWithError() throws {
        setupToiletsListPresenter()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: Test setup

    func setupToiletsListPresenter() {
        sut = ToiletsListPresenter()
    }
    
    class ToiletsListDisplayLogicSpy: ToiletsListDisplayLogic {
        var displayToiletsListCalled = false
        func displayToiletsList(viewModels: [ToiletsList.ViewModel]) {
            displayToiletsListCalled = true
        }
        
        var displayErrorCalled = false
        func displayError(message: String?) {
            displayErrorCalled = true
        }
    }
    
    func testPresentToiletsList() {
        let viewController = ToiletsListDisplayLogicSpy()
        sut.viewController = viewController
        sut.presentToiletsList(response: ToiletsList.Response(toiletDetails: [], userLatitude: 48, userLongitude: 2))
        XCTAssertTrue(viewController.displayToiletsListCalled, "presentToiletsList(:) should ask the view controller to display the result")
        
        sut.presentError()
        XCTAssertTrue(viewController.displayErrorCalled, "presentError(:) should ask the view controller to display the result")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
