//
//  IAPManager.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 17..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import StoreKit

class IAPManager: NSObject {
    
    static let shared = IAPManager()
    
    var onReceiveProductsHandler: ((Result<SKProduct, IAPManagerError>) -> Void)?
    var onBuyProductHandler: ((Result<Bool, Error>) -> Void)?
    var restoredPurchase = false

    enum IAPManagerError: Error {
        case noProductIDsFound // It indicates that the product identifiers could not be found.
        case noProductsFound //  No IAP products were returned by the App Store because none was found.
        case paymentWasCancelled // The user cancelled an initialized purchase process.
        case productRequestFailed // The app cannot request App Store about available IAP products for some reason.
        
        var errorDescription: String {
            switch self {
            case .noProductIDsFound: return "No In-App Purchase product identifiers were found."
            case .noProductsFound: return "No In-App Purchases were found."
            case .productRequestFailed: return "Unable to fetch available In-App Purchase products at the moment."
            case .paymentWasCancelled: return "In-App Purchase process was cancelled."
            }
        }
    }
    
    private override init() {
        super.init()
    }
    
    fileprivate func getProductIDs() -> [String]? {
        guard let url = Bundle.main.url(forResource: "IAP_ProductIDs", withExtension: "plist") else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            let productIDs = try PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil) as? [String] ?? []
            return productIDs
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getProducts(withHandler productsReceiveHandler: @escaping (_ result: Result<SKProduct, IAPManagerError>) -> Void) {
        onReceiveProductsHandler = productsReceiveHandler
    
        guard let productIDs = getProductIDs(), productIDs.count > 0 else {
            productsReceiveHandler(.failure(.noProductIDsFound))
            return
        }
        
        let request = SKProductsRequest(productIdentifiers: Set(productIDs))
        request.delegate = self
        request.start()
    }
    
    func getPriceFormatted(for product: SKProduct) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = product.priceLocale
        return formatter.string(from: product.price)
    }
    
    func startObserving() {
        SKPaymentQueue.default().add(self)
    }
     
     
    func stopObserving() {
        SKPaymentQueue.default().remove(self)
    }
    
    func canMakePayments() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    func buy(product: SKProduct, withHandler handler: @escaping ((_ result: Result<Bool, Error>) -> Void)) {
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
     
        // Keep the completion handler.
        onBuyProductHandler = handler
    }
    
    func restorePurchases(withHandler handler: @escaping ((_ result: Result<Bool, Error>) -> Void)) {
        onBuyProductHandler = handler
        restoredPurchase = false
        SKPaymentQueue.default().restoreCompletedTransactions()
    }

}

extension IAPManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let products = response.products

        if products.count > 0 {
            onReceiveProductsHandler?(.success(products[0]))
        } else {
            onReceiveProductsHandler?(.failure(.noProductsFound))
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        onReceiveProductsHandler?(.failure(.productRequestFailed))
    }
}

extension IAPManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach { (transaction) in
            switch transaction.transactionState {
            case .purchased:
                onBuyProductHandler?(.success(true))
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                restoredPurchase = true
                SKPaymentQueue.default().finishTransaction(transaction)
            case .failed:
                if let error = transaction.error{
                    onBuyProductHandler?(.failure(error))
                }
            default:
                break
            }
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        if restoredPurchase {
              onBuyProductHandler?(.success(true))
          } else {
              print("IAP: No purchases to restore!")
              onBuyProductHandler?(.success(false))
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        print("IAP Restore Error:", error.localizedDescription)
        onBuyProductHandler?(.failure(error))
    }
    
}
