//
//  CoinData.swift
//  ByteCoin
//
//  Created by Pino Omodei on 12/03/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Decodable {
    let asset_id_quote: String
    let rate: Double
}
