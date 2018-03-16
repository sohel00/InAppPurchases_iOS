//
//  ViewController.swift
//  InAppPurchases_iOS
//
//  Created by Sohel Dhengre on 14/03/18.
//  Copyright © 2018 Sohel Dhengre. All rights reserved.
//

import UIKit
import GoogleMobileAds

class HomeVC: UIViewController {

    @IBOutlet weak var bannerView: GADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    

}

