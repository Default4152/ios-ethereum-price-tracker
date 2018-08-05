//
//  ViewController.swift
//  Ethereum Price Tracker
//
//  Created by Conner on 8/5/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet var jpyLabel: UILabel!
    @IBOutlet var eurLabel: UILabel!
    @IBOutlet var usdLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        getPrice()
    }

    func setCurrencyForLabel(currencyCode: String, currentPrice: Double) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        return formatter.string(from: NSNumber(value: currentPrice))
    }

    func getPrice() {
        guard let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD,EUR,JPY") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Double]
                    guard let jsonData = json else { return }
                    DispatchQueue.main.async {
                        if let ethToUSD = jsonData["USD"] { self.usdLabel.text = self.setCurrencyForLabel(currencyCode: "USD", currentPrice: ethToUSD) }
                        if let ethToEUR = jsonData["EUR"] { self.eurLabel.text = self.setCurrencyForLabel(currencyCode: "EUR", currentPrice: ethToEUR) }
                        if let ethToJPY = jsonData["JPY"] { self.jpyLabel.text = self.setCurrencyForLabel(currencyCode: "JPY", currentPrice: ethToJPY) }
                    }
                } catch {
                    NSLog("\(error)")
                }
            } else {
                NSLog("\(String(describing: error))")
            }
        }.resume()
    }

    @IBAction func refreshPrices(_ sender: Any) {
        getPrice()
    }

}

