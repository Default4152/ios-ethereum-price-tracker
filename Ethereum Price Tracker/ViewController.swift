//
//  ViewController.swift
//  Ethereum Price Tracker
//
//  Created by Conner on 8/5/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func getPrice() {
        guard let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD,EUR,CNY") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
        }
    }

}

