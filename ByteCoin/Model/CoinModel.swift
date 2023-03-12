//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Pino Omodei on 12/03/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let currency: String
    let rate: Double
    
    var rateString: String {
        return (String(format: "%.2f", rate))
    }
}
