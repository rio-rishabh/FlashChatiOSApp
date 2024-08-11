//
//  CharacterExtensions.swift
//  Flash Chat iOS13
//
//  Created by Rishabh Sharma on 03/08/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import Foundation

extension Character{
    var isEmoji: Bool {
           guard let scalar = unicodeScalars.first else { return false }
           return scalar.properties.isEmoji && (scalar.value > 0x238C || scalar.properties.isEmojiPresentation)
       }
}
