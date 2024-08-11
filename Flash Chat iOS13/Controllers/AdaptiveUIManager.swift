//
//  AdaptiveUIManager.swift
//  Flash Chat iOS13
//
//  Created by Rishabh Sharma on 06/08/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

class AdaptiveUIManager{
    
    static let shared = AdaptiveUIManager()
    
    func updateColorScheme(for view: UIView, basedOn sentiment : Double ) -> UIColor{
//        UIView.animate(withDuration: 1.0) {
            if sentiment > 0.5{
//                view.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.5)
                return UIColor.systemGreen.withAlphaComponent(0.1)
                print("Updating color scheme. Sentiment: \(sentiment)")            }
            
            else if sentiment < -0.5{
//                view.backgroundColor = UIColor.systemRed.withAlphaComponent(0.5)
                return UIColor.systemRed.withAlphaComponent(0.1)
                print("Updating color scheme. Sentiment: \(sentiment)")
            }
            
            else{
//                view.backgroundColor = UIColor.systemBackground
                return UIColor.clear
            }
//        }
    }
    
    func updateFontSize(for textField : UITextField, basedOn messageLength: Double){
        let newSize = max(min(16-(messageLength/20), 16), 12)
        textField.font = UIFont.systemFont(ofSize: CGFloat(newSize))
//        let baseFontSize : CGFloat = 13.0
//        let maxFontSize : CGFloat = 17.0
//        let minFontSize : CGFloat = 14.0
//        
//        let fontSizeMultiplier = max(0.5, min(1.5, Double(messageLength) / 50.0))
//        let fontSize = max(minFontSize, min(maxFontSize, baseFontSize * CGFloat(fontSizeMultiplier)))
//        
//        textField.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
    }
    
    func updateFontSize(for label: UILabel , basedOn messageLength : Double){
        let newSize = max(min(16-(messageLength/20), 16), 12)
        label.font = UIFont.systemFont(ofSize: CGFloat(newSize))
    }
}
