//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didCoinChanged (_ coinManager: CoinManager, coin: CoinModel)
    func coinFailedWithError (_ coinManager: CoinManager, _ error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    private let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    private let apiKey = "560914A6-BB75-4702-8FE8-F5153F137DB2"
    
    private let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    var numberOfCurrencies: Int {
        return currencyArray.count
    }
    
    func getCurrencyById (id: Int) -> String {
        return currencyArray[id]
    }
    
    func getCoinPrice (for currency:String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(urlString)
    }
    
    private func performRequest(_ urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.coinFailedWithError(self, error!)
                    return
                }
                if let safeData = data {
                    if let coin = parseJSON(coinData: safeData) {
                        delegate?.didCoinChanged(self, coin: coin)
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON (coinData: Data) -> CoinModel? {
        // print(String(data: coinData, encoding: .utf8)!)
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let coin = CoinModel(currency: decodedData.asset_id_quote, rate: decodedData.rate)
            return coin
        } catch {
            delegate?.coinFailedWithError(self, error)
            return nil
        }
        
    }
}
