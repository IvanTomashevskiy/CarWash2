//
//  MainViewController.swift
//  CarWash
//
//  Created by Иван on 22.07.2020.
//  Copyright © 2020 Ivan Tomashevskiy. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    private let openWeatherManager = OpenWeatherManager.sharedInstance
    private let locationManager = LocationManager()
    
    @IBOutlet weak var mainDescriptionLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        locationManager.setUp(with: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cityLabel.text = openWeatherManager.city
    }
//        let id = weather.weatherDescription.first?.id
//            switch id{
//              case 800:
//                  mainDescriptionLbl.text = "1"
//              case 801:
//                  mainDescriptionLbl.text = "2"
//              case 802:
//                  mainDescriptionLbl.text = "3"
//              case 803:
//                  mainDescriptionLbl.text = "4"
//              case 804:
//                  mainDescriptionLbl.text = "5"
//              default:
//                  mainDescriptionLbl.text = "6"
//              }
//
    
    
    //Жирный текст
    func addBoldText(fullString: NSString, boldPartsOfString: Array<NSString>, font: UIFont!, boldFont: UIFont!) -> NSAttributedString {
        let nonBoldFontAttribute = [NSAttributedString.Key.font:font!]
        let boldFontAttribute = [NSAttributedString.Key.font:boldFont!]
        let boldString = NSMutableAttributedString(string: fullString as String, attributes:nonBoldFontAttribute)
        for i in 0 ..< boldPartsOfString.count {
            boldString.addAttributes(boldFontAttribute, range: fullString.range(of: boldPartsOfString[i] as String))
        }
        return boldString
    }
    let normalFont = UIFont(name: "Dosis-Medium", size: 18)
    let boldSearchFont = UIFont(name: "Dosis-Bold", size: 18)

    
    
    
    private func getUserLocation() {
        
        if let currentLocation = locationManager.currentLocation {
            
            locationManager.getLocation(for: currentLocation) { (placemark) in
               
               if let currentLocation = placemark,
                   let city = currentLocation.locality {
                    
                    self.cityLabel.text = city
                    self.openWeatherManager.city = city
                    self.getWeather()
               }
           }
        } else {
            
            getWeather()
        }
    }
    
    private func setUpTableView() {
        
        WeatherTableViewCell.register(with: tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
        // Remove extra empty cells from showing up in tableView
        tableView.tableFooterView = UIView()
    }
    
    @IBAction private func didTapSettingsButton(_ sender: UIButton) {
        let settingsViewController = SettingsViewController()
        settingsViewController.delegate = self
        settingsViewController.modalPresentationStyle = .overFullScreen
        present(settingsViewController, animated: true, completion: {})
    }
    
    private func getWeather() {
        
        activityLoader.startAnimating()
        
        OpenWeatherManager.sharedInstance.getFiveDayForecast { (success) in

            if success {
                
                DispatchQueue.main.async {
                    self.activityLoader.stopAnimating()
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        
        status == .authorizedWhenInUse ? getUserLocation() : getWeather()
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    
    func didTapClose() {
        
        getWeather()
        cityLabel.text = openWeatherManager.city
    }
}


extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return openWeatherManager.allWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier)
            as? WeatherTableViewCell else {

                fatalError("cellForRowAt error")
        }
        
        cell.configure(with: openWeatherManager.allWeather[indexPath.row])
        return cell
    }
}
