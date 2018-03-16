//
//  ViewController.swift
//  CoinTicker
//
//  Created by Ahmed Ramy on 2/19/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit
import MarqueeLabel
import CryptoCurrencyKit


class CurrentCurrencyCoinViewController: UIViewController
{
    
    //MARK: Outlets
    
    @IBOutlet weak var currentCurrencyLabel: UILabel!
    @IBOutlet weak var currentCoinNameLabel: UILabel!
    @IBOutlet weak var currentCoinPriceLabel: MarqueeLabel!
    
    var currentCoin : String = "BitCoin"
    var currentCurrency : String = "USD"
    var currentCoinPrice : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getDefaultData()
        currentCoinPriceLabel.makeRound()
      
    }

    func getDefaultData()
    {
        CryptoCurrencyKit.fetchTicker(coinName: "BitCoin" , convert: .usd)
        {
            response in switch response
            {
            case .success(let BitCoin):
                print ("Successfully retrieved the data !")
                self.currentCoinPrice = "\(String(describing: Double(BitCoin.priceUSD!).rounded(toPlaces: 4))) $"
                self.updateUI()
                
            case .failure(let error):
                print ("Failed to retreive the data ! \nError Log : \(error)")
                self.currentCoinPriceLabel.text = "Failed to Fetch Ticker Data"
            }
            
        }
    }
    
    func getChosenCoinData(coin : String , currency : CryptoCurrencyKit.Money.RawValue)
    {
        let symbol = CryptoCurrencyKit.Money.init(rawValue: currency)?.symbol
        CryptoCurrencyKit.fetchTicker(coinName: coin, convert: CryptoCurrencyKit.Money(rawValue: currency)!)
        {
            response in switch response
            {
            case .success(let coinInfo):
                print("Successfully Retrieved coin info !")
                self.currentCoinPriceLabel.text = "\(String(describing: coinInfo.price(for: CryptoCurrencyKit.Money(rawValue: currency)!)!.rounded(toPlaces: 3))) \(symbol!)  "
                self.currentCoinNameLabel.text = coinInfo.name
                self.currentCurrencyLabel.text = currency
//                self.updateUI()
            
            case .failure(let error):
                print("Failed to fetch ticker data! ")
                print(error.localizedDescription)
                self.currentCurrencyLabel.text = currency
                self.currentCoinPriceLabel.text = "Failed to Fetch Ticker Data"
            }
        }
    }
    
    func updateUI()
    {
        currentCoinPriceLabel.text = currentCoinPrice
        currentCurrencyLabel.text = currentCurrency
        currentCoinNameLabel.text = currentCoin
    }
    
    //MARK: Action Outlets
    
    
    @IBAction func switchBtnPressed(_ sender: Any)
    {
        let targetViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChangeCurrencyCoinViewController") as! ChangeCurrencyCoinViewController
        
        targetViewController.delegate = self
        
        self.navigationController?.pushViewController(targetViewController, animated: true)
    }
    
}

extension CurrentCurrencyCoinViewController : ChangeCurrencyCoinViewControllerDelegate
{
    func selectedCoinAndCurrency(coin : String , currency : String)
    {
        getChosenCoinData(coin: coin, currency: currency)
    }
}



