//
//  ToiletDetailsViewController.swift
//  ToiletsAppTest
//
//  Created by Yasin Akinci on 10/03/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ToiletDetailsDisplayLogic: class {
    func displayToiletDetails(viewModel: ToiletDetails.ViewModel)
}

class ToiletDetailsViewController: UIViewController, ToiletDetailsDisplayLogic {
    var interactor: ToiletDetailsBusinessLogic?
    var router: (NSObjectProtocol & ToiletDetailsRoutingLogic & ToiletDetailsDataPassing)?

    @IBOutlet weak var fullAddressLabel : UILabel!
    @IBOutlet weak var hourLabel : UILabel!
    @IBOutlet weak var isPMRLabel : UILabel!
    @IBOutlet weak var distanceLabel : UILabel!
    
    
    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = ToiletDetailsInteractor()
        let presenter = ToiletDetailsPresenter()
        let router = ToiletDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchToiletDetails()
    }

    // MARK: Do something

    func fetchToiletDetails() {
        let request = ToiletDetails.Request()
        interactor?.fetchToiletDetails(request: request)
    }

    func displayToiletDetails(viewModel: ToiletDetails.ViewModel) {
        fullAddressLabel.text = viewModel.fullAddress
        hourLabel.text = viewModel.openingHour
        isPMRLabel.text = viewModel.isPMR
        distanceLabel.text = viewModel.distance
    }
}
