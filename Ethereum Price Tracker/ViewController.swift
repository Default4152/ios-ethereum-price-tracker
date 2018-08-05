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

    func getPrice() {
        guard let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD,EUR,JPY") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Double]
                    guard let jsonData = json else { return }
                    DispatchQueue.main.async {
                        guard let ethToUSD = jsonData["USD"] else { return }
                        guard let ethToEUR = jsonData["EUR"] else { return }
                        guard let ethToJPY = jsonData["JPY"] else { return }
                        
                        self.usdLabel.text = "$\(ethToUSD)"
                        self.eurLabel.text = "€\(ethToEUR)"
                        self.jpyLabel.text = "¥\(ethToJPY)"
                    }
                } catch {
                    NSLog("\(error)")
                }
            } else {
                NSLog("\(String(describing: error))")
            }
        }.resume()
    }

}

