//
//  DraggableButton.swift
//  MonsterMaintenance
//
//  Created by Felix Barros on 12/13/15.
//  Copyright © 2015 Bits That Matter. All rights reserved.
//

import Foundation
import UIKit

class DraggableButton: UIButton {
    var originalCenter: CGPoint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        originalCenter = self.center
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            self.center = touch.locationInView(self.superview)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.center = originalCenter
    }
}
