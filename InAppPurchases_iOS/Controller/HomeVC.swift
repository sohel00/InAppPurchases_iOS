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

    @IBOutlet weak var removeAdsButton: UIButton!
   
    @IBOutlet weak var bannerView: GADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.bool(forKey: PurchaseManager.instance.IAP_REMOVE_ADS) == true {
            removeAdsButton.removeFromSuperview()
        } else if UserDefaults.standard.bool(forKey: PurchaseManager.instance.IAP_REMOVE_ADS) == false {
            bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
        }
        else {
            bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
            
        }
        
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func removeAdsPressed(_ sender: Any) {
        PurchaseManager.instance.purchaseRemoveAds { (success) in
            if success{
                self.bannerView.removeFromSuperview()
                self.removeAdsButton.removeFromSuperview()
            } else {
                // print message for the user
            }
        }
    }
    
    
    

}

