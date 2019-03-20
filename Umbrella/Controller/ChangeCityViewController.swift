//
//  ChangeCityViewController.swift
//  Umbrella
//
//  Created by Thomas Thorsager on 26/10/2018.
//  Copyright © 2018 TThorsager. All rights reserved.
//

import UIKit

//Protocol
protocol ChangeCityDelegate {
    func newCityNameEntered(city : String)
}

class ChangeCityViewController: UIViewController {
    
    //Properties
    var delegate : ChangeCityDelegate?

    //IBOutlets
    @IBOutlet weak var changeCotyTextField: UITextField!
    @IBAction func getWeathertapped(_ sender: Any) {
        //User entered text saved in let cityName
        let cityName = changeCotyTextField.text!
        
        //If delegate is set, parse text from textfield to UmbrellaViewController
        delegate?.newCityNameEntered(city: cityName)
        
        //Dismiss current view (with animation) and return to main view
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //Return to the initial view
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
