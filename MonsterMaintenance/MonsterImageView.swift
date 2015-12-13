//
//  MonsterImageView.swift
//  MonsterMaintenance
//
//  Created by Felix Barros on 12/13/15.
//  Copyright © 2015 Bits That Matter. All rights reserved.
//

import Foundation
import UIKit

class MonsterImageView: UIImageView {
    func playIdleAnimation() {
        var arrayOfImages = [UIImage]()
        for i in 1...4 {
            if let image = UIImage(named: "idle (\(i)).png") {
                arrayOfImages.append(image)
            }
        }
        self.animationImages = arrayOfImages
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
    func playDeathAnimation() {
        var arrayOfImages = [UIImage]()
        for i in 1...5 {
            if let image = UIImage(named: "dead\(i).png") {
                arrayOfImages.append(image)
                if i == 5 {
                    // Set last image as the default when animation completes
                    self.image = image
                }
            }
        }
        self.animationImages = arrayOfImages
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
    }
}
