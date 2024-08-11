//
//  EmojiSuggestionView.swift
//  Flash Chat iOS13
//
//  Created by Rishabh Sharma on 04/08/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

class EmojiSuggestionView : UIView{
    
    var stackView :UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        setupInitialFrameAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
        setupInitialFrameAndConstraints()
    }
    
    private func setupInitialFrameAndConstraints() {
        stackView.frame = bounds
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupStackView(){
        stackView = UIStackView()
        
        stackView.frame = bounds
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: topAnchor),
                                     stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     stackView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
    override func layoutSubviews() {
        super.layoutSubviews()
                print("Yeh Dil Maange More.")
                print("EmojiSuggestionView layout: frame = \(frame), bounds = \(bounds)")
                print("StackView layout: frame = \(stackView.frame), bounds = \(stackView.bounds)")
        
    }
    
    func updateEmojis(_ emojis : [String]){
        print("Updating emojis: \(emojis)")
        DispatchQueue.main.async{
            self.stackView.arrangedSubviews.forEach{ $0.removeFromSuperview()}
            
            for emoji in emojis {
                let button = UIButton()
                button.setTitle(emoji, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
                button.backgroundColor = .systemBlue
                button.layer.cornerRadius = 15
                button.widthAnchor.constraint(equalToConstant: 30).isActive = true
                button.heightAnchor.constraint(equalToConstant: 30).isActive = true
                button.addTarget(nil, action: #selector(ChatViewController.emojiButtonTapped(_:)), for: .touchUpInside)
                self.stackView.addArrangedSubview(button)
            }
        }
    }
}
