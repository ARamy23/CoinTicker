//
//  ChangeCurrencyCoinViewController.swift
//  CoinTicker
//
//  Created by Ahmed Ramy on 2/19/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit
import MarqueeLabel
import CryptoCurrencyKit

protocol ChangeCurrencyCoinViewControllerDelegate
{
    func selectedCoinAndCurrency(coin : String , currency : CryptoCurrencyKit.Money.RawValue)
}

class ChangeCurrencyCoinViewController: UIViewController {

    
    @IBOutlet weak var currencyCoinPickerView: UIPickerView!
    @IBOutlet weak var hintLabel: MarqueeLabel!
    @IBOutlet weak var fetchDataBtn: UIButton!
    
    
    var coinsNames : [String] = []
    var currenciesNames : [String] = []
    var selectedCoin : String = ""
    var selectedCurrency : CryptoCurrencyKit.Money.RawValue = ""
    
    var delegate : ChangeCurrencyCoinViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyCoinPickerView.delegate = self
        currencyCoinPickerView.dataSource = self
        getMarketData()
        hintLabel.setMarqueeLabelStyle()
        hintLabel.makeRound()
        fetchDataBtn.makeExtraRound()
        
        
    }
    
    func getMarketData()
    {
        currenciesNames = CryptoCurrencyKit.Money.allRawValues
        CryptoCurrencyKit.fetchTickers
        {
            response in switch response
            {
            case .success(let coinsInfo):
                print("Successfully retrieved Market Data")
                for coinName in coinsInfo
                {
                    self.coinsNames.append(coinName.name)
                    
                }
                DispatchQueue.main.async {
                    self.currencyCoinPickerView.reloadComponent(0)
                }
                
            case .failure(let error):
                print("Failed to retrieve Market data\n\(error.localizedDescription)")
                
            }
        }
    }
    
    //MARK: Action Outlets
    
    @IBAction func fetchDataBtnPressed(_ sender: Any)
    {
        DispatchQueue.main.async {
            self.currencyCoinPickerView.reloadAllComponents()
        }
        if delegate != nil && selectedCoin != "" && selectedCurrency != ""
        {
            self.delegate?.selectedCoinAndCurrency(coin: self.selectedCoin, currency: self.selectedCurrency)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChangeCurrencyCoinViewController : UIPickerViewDelegate , UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0
        {
            return coinsNames.count
        }
        else if component == 1
        {
            return currenciesNames.count
        }
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? coinsNames[row] : currenciesNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0
        {selectedCoin = coinsNames[row]}
        else if component == 1
        {selectedCurrency = currenciesNames[row]}
        
        
        
    }
    
    
}
