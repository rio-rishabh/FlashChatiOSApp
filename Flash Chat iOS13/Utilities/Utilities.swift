//
//  Utilities.swift
//  Flash Chat iOS13
//
//  Created by Rishabh Sharma on 30/07/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

final class Utilities {
    
    static let shared =  Utilities()
    private init() {}
    
    @MainActor
     func topViewController(controller: UIViewController? = nil) -> UIViewController? {
         
         let controller = controller ?? UIApplication.shared.keyWindow?.rootViewController
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
