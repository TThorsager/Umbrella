//
//  UmbrellaDataModel.swift
//  Umbrella
//
//  Created by Thomas Thorsager on 26/10/2018.
//  Copyright © 2018 TThorsager. All rights reserved.
//

import UIKit

class WeatherDataModel {
    
    //Data model variables
    var temperature : Int = 0
    var condition : Int = 0
    var city : String = ""
    var weatherIconName : String = ""
    var recommendation : String = ""
    var weatherBackgroundName : String = ""
    var umbrellaIconName : String = ""

    
    //Method to turn condition value into the name of the weather condition image
    func updateWeatherIcon(condition:Int) -> String {
        switch (condition) {
        case 0...299 :
            return "http://openweathermap.org/img/w/11d.png"
            
        case 300...499 :
            return "http://openweathermap.org/img/w/09d.png"
            
        case 500...599 :
            return "http://openweathermap.org/img/w/10d.png"
            
        case 600...699 :
            return "http://openweathermap.org/img/w/13d.png"
            
        case 700...771 :
            return "http://openweathermap.org/img/w/50d.png"
            
        case 772...799 :
            return "http://openweathermap.org/img/w/11d.png"
            
        case 800 :
            return "http://openweathermap.org/img/w/01d.png"
            
        case 801 :
            return "http://openweathermap.org/img/w/02d.png"
            
        case 802 :
            return "http://openweathermap.org/img/w/03d.png"
        
        case 803...804 :
            return "http://openweathermap.org/img/w/04d.png"
        
        case 900...903, 905...1000  :
            return "http://openweathermap.org/img/w/11d.png"
            
        case 903 :
            return "http://openweathermap.org/img/w/13d.png"
            
        case 904 :
            return "http://openweathermap.org/img/w/01d.png"
            
        default :
           return "Error"
        }
    }
    
    
    //MARK: Recommendation switch case
    func updateRecommendation(condition:Int) -> String {
        switch (condition) {
        case 0...299 :
            return "We recommend you to stay inside"
            
        case 300...499 :
            return "We recommend you to bring an umbrella"
            
        case 500...599 :
            return "We recommend you to bring an umbrella"
            
        case 600...699 :
            return "We recommend you to drive slow"
            
        case 700...771 :
            return "We recommend you to drive slow"
            
        case 772...799 :
            return "We recommend you to find shelter"
            
        case 800 :
            return "We recommend you to go outside and enjoy the weather"
            
        case 801 :
            return "We recommend you to go outside and enjoy the weather"
            
        case 802 :
            return "We recommend you to might bring an umbrella"
            
        case 803...804 :
            return "We recommend you to bring an umbrella"
            
        case 900...903, 905...1000  :
            return "We recommend you to stay inside"
            
        case 903 :
            return "We recommend you to stay inside"
            
        case 904 :
            return "We recommend you to go outside and enjoy the weather"
            
            
        default :
            return "Error"
        }
    }
    
    
    //MARK: Weather background image switch case
    func updateWeatherBachground(condition:Int) -> String {
        switch (condition) {
        case 0...299 :
            return "We recommend you to stay inside"
            
        case 300...499 :
            return "3xxRain"
            
        case 500...599 :
            return "3xxRain"
            
        case 600...699 :
            return "6xxSnow"
            
        case 700...771 :
            return "7xxFog"
            
        case 772...799 :
            return "We recommend you to find shelter"
            
        case 800 :
            return "800Clear"
            
        case 801 :
            return "80xCloudy"
            
        case 802 :
            return "80xCloudy"
            
        case 803...804 :
            return "80xCloudy"
            
        case 900...903, 905...1000  :
            return "We recommend you to stay inside"
            
        case 903 :
            return "We recommend you to stay inside"
            
        case 904 :
            return "800Clear"
            
            
        default :
            return "Error"
        }
    }
    
    
    //MARK: Umbrella icon switch case
    func updateUmbrellaIcon(condition:Int) -> String {
        switch (condition) {
        case 0...299 :
            return "We recommend you to stay inside"
            
        case 300...499 :
            return "openUmbrella"
            
        case 500...599 :
            return "openUmbrella"
            
        case 600...699 :
            return "We recommend you to drive slow"
            
        case 700...771 :
            return "We recommend you to drive slow"
            
        case 772...799 :
            return "We recommend you to find shelter"
            
        case 800 :
            return "closedUmbrella"
            
        case 801 :
            return "closedUmbrella"
            
        case 802 :
            return "We recommend you to might bring an umbrella"
            
        case 803...804 :
            return "openUmbrella"
            
        case 900...903, 905...1000  :
            return "We recommend you to stay inside"
            
        case 903 :
            return "We recommend you to stay inside"
            
        case 904 :
            return "closedUmbrella"
            
            
        default :
            return "Error"
        }
    }
    
    
}
