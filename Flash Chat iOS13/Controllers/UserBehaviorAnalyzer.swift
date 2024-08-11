//
//  UserBehaviorAnalyzer.swift
//  Flash Chat iOS13
//
//  Created by Rishabh Sharma on 03/08/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import Foundation

class UserBehaviorAnalyzer{
    static let shared = UserBehaviorAnalyzer()
    
    var messageLength : Double = 0
    var emojiFrequency : [String : Int] = [:]
    var sentimentScore : Double = 0
    var readingSpeed : Double = 0
    private let maxSuggestedEmojis = 5
    
    
    func analyzeMessage(_ message: Message){
        
        messageLength = (messageLength + Double(message.body.count))/2
        
        let emojis = message.body.filter{$0.isEmoji}
        for emoji in emojis {
            emojiFrequency[String(emoji), default: 0] += 1
        }
        
        let positiveWords = ["Excellent", "Outstanding", "Exceptional", "Brilliant", "Fantastic", "Wonderful", "Amazing", "Incredible", "Inspiring", "Motivating", "Uplifting", "Encouraging", "Supportive", "Helpful", "Kind", "Generous", "Thoughtful", "Considerate", "Empathetic", "Confident", "Determined", "Resilient", "Adaptable", "Flexible", "Creative", "Innovative", "Enthusiastic", "Passionate", "Dedicated", "Committed", "Sincere"]
        
        let negativeWords = ["Awful", "Terrible", "Horrible", "Bad", "Worst", "Ugly", "Sad", "Depressing", "Frustrating", "Annoying", "Angry", "Bitter", "Resentful", "Jealous", "Envious", "Hateful", "Malicious", "Cruel", "Heartless", "Ruthless", "Cold", "Harsh", "Bitter", "Sarcastic", "Cynical", "Pessimistic", "Discouraging", "Unhelpful", "Unkind", "Unfair", "Unjust"]
        
//        let words = message.body.lowercased().components(separatedBy: .whitespacesAndNewlines)
//        
//        let positiveCount = words.filter { positiveWords.contains($0) }.count
//        let negativeCount = words.filter{negativeWords.contains($0)}.count
//        
//        sentimentScore = Double(positiveCount - negativeCount) / Double(words.count)
//        sentimentScore = max(-1.0, min(1.0, sentimentScore))
                let sentiment = SentimentAnalyzer.analyzeSentiment(of: message.body)
        sentimentScore = (sentimentScore + sentiment) / 2
        
        
        let sentimentCategory = SentimentAnalyzer.getSentimentCategory(sentimentScore)
       

    }
    
    func getMostUsedEmojis(limit: Int = 5) -> [String] {
           return Array(emojiFrequency.sorted { $0.value > $1.value }.prefix(maxSuggestedEmojis)).map { $0.key }
       }
    
}
