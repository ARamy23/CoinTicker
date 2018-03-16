//
//  Extensions.swift
//  CoinTicker
//
//  Created by Ahmed Ramy on 2/19/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit
import MarqueeLabel

extension MarqueeLabel
{
    func setMarqueeLabelStyle()
    {
        self.marqueeType = .MLContinuous
        self.scrollDuration = 5.0
        self.animationCurve = .curveEaseInOut
        self.fadeLength = 10.0
        self.leadingBuffer = 30.0
        self.trailingBuffer = 20.0
    }
}

extension UIView
{
    func makeRound()
    {
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        self.layer.borderWidth = 1
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }
}

extension UIButton
{
    func makeExtraRound()
    {
        self.layer.cornerRadius = self.frame.height / 4
        self.titleLabel?.adjustsFontSizeToFitWidth = true
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}



