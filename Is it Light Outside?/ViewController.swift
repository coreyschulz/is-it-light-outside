//
//  ViewController.swift
//  Is it Light Outside?
//
//  Created by Corey Schulz on 3/20/18.
//  Copyright © 2018 Corey Schulz. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yesNoLabel: UILabel!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // locationManager SETUP
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // END locationManager SETUP
        
        self.yesNoLabel.text = "..."
        
        // Get user location, need Latitude && Longitude...
        
        var currentLocation: CLLocation!
        
        // If the app has authorization to use location...
        if(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
           CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways)
        {
            currentLocation = locationManager.location
            
            // Establishes current date from system time.
            //let currentDate = Date().description(with: .current)
            
            let currentDate = Date()
            
            print(currentDate)
            
            
            var dateComponents = DateComponents()
            dateComponents.year   = 2002 // Parse components from currentDate, put into dateComponents!
            dateComponents.month  = 6
            dateComponents.day    = 1
            dateComponents.hour   = 7+12
            dateComponents.minute = 13
            dateComponents.timeZone = TimeZone(abbreviation: "MDT")
            
            let userCalender = Calendar.current
            let currentDateTime = userCalender.date(from: dateComponents)
            
            print(currentDateTime)
 
 
            
            let solar = Solar(for:currentDate, coordinate:currentLocation.coordinate)
            
            if(solar?.isDaytime)!
            {
                self.view.backgroundColor = UIColor.white
                self.titleLabel.textColor = UIColor.black
                self.yesNoLabel.textColor = UIColor.black
                self.yesNoLabel.text = "YES"
            }
            else
            {
                self.titleLabel.textColor = UIColor.white
                self.yesNoLabel.textColor = UIColor.white
                self.yesNoLabel.text = "NO"
                self.view.backgroundColor = UIColor.black
            }
            
        }
        else // Or, if app doesn't have location auth...
        {
            self.titleLabel.textColor = UIColor.white
            self.yesNoLabel.text = "Maybe."
            self.yesNoLabel.textColor = UIColor.white
            self.view.backgroundColor = UIColor.darkGray
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

