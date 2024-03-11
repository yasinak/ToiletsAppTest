//
//  ToiletDetailsPresenterTests.swift
//  ToiletsAppTestTests
//
//  Created by Yasin Akinci on 11/03/2024.
//

import XCTest
@testable import ToiletsAppTest

class ToiletDetailsPresenterTests: XCTestCase {

    // MARK: Subject under test

    var sut: ToiletDetailsPresenter!
    
    override func setUpWithError() throws {
        setupToiletDetailsPresenter()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: Test setup

    func setupToiletDetailsPresenter() {
        sut = ToiletDetailsPresenter()
    }

    class ToiletDetailsDisplayLogicSpy: ToiletDetailsDisplayLogic {
        var displayToiletDetailsCalled = false
        func displayToiletDetails(viewModel: ToiletDetails.ViewModel) {
            displayToiletDetailsCalled = true
        }
    }
    
    func testPresentProductDetails() {
        let viewController = ToiletDetailsDisplayLogicSpy()
        sut.viewController = viewController
        let response = ToiletDetails.Response(address: "",
                                              district: 75009,
                                              onlyPMR: "true",
                                              openingHour: "de 9h à 15h",
                                              toiletLatitude: 48,
                                              toiletLongitude: 2,
                                              userLatitude: 48,
                                              userLongitude: 2)
        sut.presentToiletDetails(response: response)

        XCTAssertTrue(viewController.displayToiletDetailsCalled, "presentToiletDetails(:) should ask the view controller to display the result")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
