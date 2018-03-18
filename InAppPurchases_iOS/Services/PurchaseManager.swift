//
//  PurchaseManager.swift
//  InAppPurchases_iOS
//
//  Created by Sohel Dhengre on 14/03/18.
//  Copyright © 2018 Sohel Dhengre. All rights reserved.
//

import Foundation
import StoreKit

typealias completionHandler = (_ status: Bool)->()

class PurchaseManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    
    
    static let instance = PurchaseManager()
    let IAP_REMOVE_ADS = "Nick.InAppPurchasesiOS.remove.ads"
    var productRequest: SKProductsRequest!
    var products = [SKProduct]()
    var transactionComplete: completionHandler!
    
    func fetchProducts(){
        let productIds = NSSet(object: IAP_REMOVE_ADS) as! Set<String>
        productRequest = SKProductsRequest(productIdentifiers: productIds)
        productRequest.delegate = self
        productRequest.start()
    }
    
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.products.count > 0 {
            print(response.products.debugDescription)
            products = response.products
        }
    }
    
    func purchaseRemoveAds(completion: @escaping completionHandler){
        
        if SKPaymentQueue.canMakePayments() && products.count > 0 {
            transactionComplete = completion
            let removeAdsProduct = products[0]
            let payment = SKPayment(product: removeAdsProduct)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
        } else {
            completion(false)
        }
    }
    
    
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                if transaction.payment.productIdentifier == IAP_REMOVE_ADS {
                    UserDefaults.standard.set(true, forKey: IAP_REMOVE_ADS)
                    transactionComplete(true)
                }
                break
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                transactionComplete(false)
                break
            case .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                transactionComplete(true)
                break
            default:
                transactionComplete(false)
                break
            }
        }
    }
    
}
