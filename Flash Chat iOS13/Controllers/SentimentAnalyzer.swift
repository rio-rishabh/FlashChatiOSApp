//
//  SentimentAnalyzer.swift
//  Flash Chat iOS13
//
//  Created by Rishabh Sharma on 03/08/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import Foundation
import NaturalLanguage

class SentimentAnalyzer{
    static func analyzeSentiment(of Text: String)-> Double{
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        tagger.string = Text
        
        guard let sentiment = tagger.tag(at: tagger.string!.startIndex, unit: .paragraph, scheme: .sentimentScore).0 else{return 0.0
        }
        
        return Double(sentiment.rawValue) ?? 0.0
    }
    
    static func getSentimentCategory(_ score: Double) -> String{
        switch score{
        case _ where score > 0.3:
            return "Positive"
        
        case _ where score < -0.3:
            return "Negative"
        
        default:
            return "Neutral"
        }
    }
}
