//
//  ViewController.swift
//  Umbrella
//
//  Created by Thomas Thorsager on 26/10/2018.
//  Copyright © 2018 TThorsager. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import AlamofireImage
import SwiftyJSON

class UmbrellaViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    //Constants
    let weatherUrl = "http://api.openweathermap.org/data/2.5/weather"
    let appID = "faeb99d277bf86f391772a7f38b4d4a1"
    
    //Instance variable
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    
    //IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var recommendationLabel: UILabel!
    @IBOutlet weak var umbrellaStateIcon: UIImageView!
    @IBOutlet weak var weatherBackground: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        //desiredAccuracy has been set to hundred meters, because of the probability
        //of the weather being the same within a hundred meter radius
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        //Asking user for premission to use their location data when the app is being used
        locationManager.requestWhenInUseAuthorization()
        
        //LocationManager starts looking for the GPS coordinates for the device
        locationManager.startUpdatingLocation()
    }

    
    //MARK: Network
    //Method for sending HTTP request to openweathermap.org
    //This method is asynchronous which means it is working in the background
    func getWeatherData(url: String, parameters: [String: String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Succes! Weather data:")
                let weatherJSON : JSON = JSON(response.result.value!)
                print(weatherJSON)
                //"self." is used because it is inside a closure caused by the "in" earlier
                self.updateWeatherData(json: weatherJSON)
                
            } else {
                print("Error: \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issues"
            }
        }
    }
    
    
    //MARK: Parsing of JSON data
    func updateWeatherData(json : JSON) {
        if let tempResult = json["main"]["temp"].double {
            //The "-273.15" is to convert from Kelvin to Celcius
            weatherDataModel.temperature = Int(tempResult - 273.15)
            
            weatherDataModel.city = json["name"].stringValue
            
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            
            weatherDataModel.recommendation = weatherDataModel.updateRecommendation(condition: weatherDataModel.condition)
            
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            
            weatherDataModel.weatherBackgroundName = weatherDataModel.updateWeatherBachground(condition: weatherDataModel.condition)
            
            weatherDataModel.umbrellaIconName = weatherDataModel.updateUmbrellaIcon(condition: weatherDataModel.condition)
            
            updateUIWithWeatherData()
            
        } else {
            weatherIcon.image = nil
            weatherBackground.image = nil
            umbrellaStateIcon.image = nil
            temperatureLabel.text = "0"
            recommendationLabel.text = "Error getting weatherdata"
            cityLabel.text = "Error"
        }
    }
    
    
    //MARK: Update UserInterface
    func updateUIWithWeatherData() {
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = String(weatherDataModel.temperature) + "°"
        weatherBackground.image = UIImage(named: weatherDataModel.weatherBackgroundName)
        umbrellaStateIcon.image = UIImage(named: weatherDataModel.umbrellaIconName)
        //Use Alamofire to request the icons via openweathermap.org and set into weatherIcon
        Alamofire.request(weatherDataModel.weatherIconName).responseImage { response in
            if let image = response.result.value {
                print("image downloaded: \(image)")
                self.weatherIcon.image = image
            }
        }
        recommendationLabel.text = weatherDataModel.recommendation
    }


    
    
    //MARK: Location Manager Delegate
    //Tells delegate that new location data i available
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //The last value in CLLocation array is the most accurate to the device location
        let location = locations[locations.count - 1]
        //Check if locationdata is valid
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            
            print("Latitude = \(location.coordinate.latitude)")
            print("Longitude = \(location.coordinate.longitude)")
            
            let latitude = String(location.coordinate.latitude)
            let logitude = String(location.coordinate.longitude)
            
            let locationParameters : [String : String] = ["lat" : latitude, "lon" : logitude, "appid" : appID]
            
            getWeatherData(url: weatherUrl, parameters: locationParameters)
        
        }
    }
    
    //If location manager is unable to retrive a location value
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    
    //MARK: Change City Delegate
    func newCityNameEntered(city: String) {
        print("User entered new city: \(city)")
        
        //"q" comes from openweathermap.org/current and is used to change city name
        let changeCityParameters : [String : String] = ["q" : city, "appID" : appID]
        
        getWeatherData(url: weatherUrl, parameters: changeCityParameters)
        
    }
    
    //Happens when going from main view to changeCity view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName" {
            let destinationVC = segue.destination as! ChangeCityViewController
            
            destinationVC.delegate = self
        }
    }
    
    
    
    
    
    
    
    
    
}

