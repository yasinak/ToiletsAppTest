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
    func displayError(message: String?)
}

class ToiletsListViewController: UIViewController, ToiletsListDisplayLogic {
    var interactor: ToiletsListBusinessLogic?
    var router: (NSObjectProtocol & ToiletsListRoutingLogic & ToiletsListDataPassing)?
    var viewModels: [ToiletsList.ViewModel]?
    var onlyPRM: Bool = false
    var index = 0
    
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
        toiletsListTableView.accessibilityIdentifier = "toiletsListTableViewIdentifier"
        toiletsListTableView.register(UINib(nibName: "ToiletDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "ToiletDetailsTableViewCell")
    }
    
    // MARK: Action
    
    @IBAction func PRMDidChange(_ sender: UISwitch) {
        onlyPRM = sender.isOn
        fetchToiletsList()
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfiguration()
        requestLocationUpdates()
    }
    
    // MARK: Fetch and Display Toilets List
    
    func fetchToiletsList() {
        let request = ToiletsList.Request(onlyPMR: onlyPRM,
                                          userLatitude: userLocation.coordinate.latitude,
                                          userLongitude: userLocation.coordinate.longitude,
                                          index: index)
        interactor?.fetchToiletsList(request: request)
    }
    
    func displayToiletsList(viewModels: [ToiletsList.ViewModel]) {
        self.viewModels = viewModels
        DispatchQueue.main.async {
            self.toiletsListTableView.reloadData()
        }
    }
    
    func displayError(message: String?) {
        DispatchQueue.main.async {
            let message = message != nil ? message : "Une erreur est survenue"
            let alert = UIAlertController(title: "Attention", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Fermer", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Location Manager
    
    var userLocation = CLLocation()
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        return manager
    }()
    
    func requestLocationUpdates() {
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            
        case .denied:
            displayError(message: "Pour pouvoir vous fournir les meilleurs informations, merci d'accepter de partager votre localisation.")
        default:
            print("Location not determined")
        }
    }
}

extension ToiletsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ToiletDetailsTableViewCell") as? ToiletDetailsTableViewCell {
            
            if let toiletDetails = self.viewModels?[indexPath.row] {
                cell.accessibilityIdentifier = "toiletDetailsTableViewCell_\(indexPath.row)"
                cell.setupCell(fullAddress: toiletDetails.fullAddress,
                               hour: toiletDetails.openingHour,
                               isPMR: toiletDetails.isPMR,
                               distance: toiletDetails.distance)
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }

    //  TODO: we need to fetch new result and add it at the bottom of the tableView
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYOffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYOffset

        if distanceFromBottom < height {
            print("You reached end of the table")
        }
    }
}

extension ToiletsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        router?.routeToToiletDetails(index: indexPath.row)
    }
}

extension ToiletsListViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.locationManager.stopUpdatingLocation()
        self.userLocation = location
        fetchToiletsList()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle failure to get a user’s location
        displayError(message: "Pour pouvoir vous fournir les meilleurs informations, merci d'accepter de partager votre localisation.")
        fetchToiletsList()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        case .denied:
            displayError(message: "Pour pouvoir vous fournir les meilleurs informations, merci d'accepter de partager votre localisation.2")
            fetchToiletsList()
        default:
            manager.stopUpdatingLocation()
        }
    }
    
}
