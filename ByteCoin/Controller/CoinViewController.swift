//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CoinViewController: UIViewController {
    
    var coinManager = CoinManager()

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
}

//MARK: - UIPickerViewDataSource
// Come l'ho capita: il PickerView chiede al dataSource quanti componenti ci sono (nel nostro caso 1)
// e poi quante righe ci sono in ogni componente (nel nostro caso, la dim dell'Array di Currency)
// Quindi parte un doppio loop sulle righe di ogni componente del Picker dove per ogni riga
// chiede al DELEGATE di dargli il TITOLO per la row corrente

extension CoinViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.numberOfCurrencies
    }
}

//MARK: - UIPickerViewDelegate

extension CoinViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.getCurrencyById(id: row)
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.getCurrencyById(id: row)
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}

//MARK: - CoinManagerDelegate

extension CoinViewController: CoinManagerDelegate {
    func coinFailedWithError(_ coinManager: CoinManager, _ error: Error) {
        print(error)
    }
    
    func didCoinChanged(_ coinManager: CoinManager, coin: CoinModel) {
        DispatchQueue.main.async {
            self.currencyLabel.text = coin.currency
            self.bitcoinLabel.text = coin.rateString
        }
    }
    
}
