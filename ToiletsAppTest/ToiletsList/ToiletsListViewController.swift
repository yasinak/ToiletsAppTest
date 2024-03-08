//
//  ToiletsListViewController.swift
//  ToiletsAppTest
//
//  Created by Yasin Akinci on 08/03/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import CoreLocation

protocol ToiletsListDisplayLogic: class {
    func displayToiletsList(viewModels: [ToiletsList.ViewModel])
    func displayError()
}

class ToiletsListViewController: UIViewController, ToiletsListDisplayLogic {
    var interactor: ToiletsListBusinessLogic?
    var router: (NSObjectProtocol & ToiletsListRoutingLogic & ToiletsListDataPassing)?
    var viewModels: [ToiletsList.ViewModel]?
    var onlyPRM: Bool = false
    
    // MARK: IBOutlet Object
    
    @IBOutlet weak var toiletsListTableView: UITableView!
    
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
        let interactor = ToiletsListInteractor()
        let presenter = ToiletsListPresenter()
        let router = ToiletsListRouter()
        let worker = ToiletsListWorker()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
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
    
    // MARK: Configuration
    private func viewConfiguration() {
        toiletsListTableView.register(UINib(nibName: "ToiletDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "ToiletDetailsTableViewCell")
    }
    
    @IBAction func PRMDidChange(_ sender: UISwitch) {
        onlyPRM = sender.isOn
        fetchToiletsList()
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfiguration()
        fetchLocation()
    }

    // MARK: Do something
    
    func fetchToiletsList() {
        let request = ToiletsList.Request(onlyPRM: onlyPRM,
                                          userLatitude: location.coordinate.latitude,
                                          userLongitude: location.coordinate.longitude)
        interactor?.fetchToiletsList(request: request)
    }

    func displayToiletsList(viewModels: [ToiletsList.ViewModel]) {
        self.viewModels = viewModels
        DispatchQueue.main.async {
            self.toiletsListTableView.reloadData()
        }
    }
    
    func displayError() {
        let alert = UIAlertController(title: "Attention", message: "Une erreur est survenue.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Fermer", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Location Manager
    
    let locationManager = CLLocationManager()
    var location = CLLocation()
    
    func fetchLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension ToiletsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ToiletDetailsTableViewCell") as? ToiletDetailsTableViewCell {
            
            if let toiletDetails = self.viewModels?[indexPath.row] {
                cell.setupCell(fullAddress: toiletDetails.fullAddress,
                               hour: toiletDetails.openingHour,
                               isPRM: toiletDetails.isPRM,
                               distance: toiletDetails.distance)
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension ToiletsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        router?.routeToToiletDetails(indexPath: indexPath)
//        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension ToiletsListViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.locationManager.stopUpdatingLocation()
        self.location = location
        fetchToiletsList()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle failure to get a user’s location
        displayError()
    }
    
}
