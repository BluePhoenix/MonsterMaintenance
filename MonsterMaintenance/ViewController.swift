//
//  ViewController.swift
//  MonsterMaintenance
//
//  Created by Felix Barros on 12/12/15.
//  Copyright © 2015 Bits That Matter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var monsterImage: MonsterImageView!
    @IBOutlet weak var heartButton: DraggableButton!
    @IBOutlet weak var foodButton: DraggableButton!
    
    @IBOutlet weak var penalty1Image: UIImageView!
    @IBOutlet weak var penalty2Image: UIImageView!
    @IBOutlet weak var penalty3Image: UIImageView!
    
    let dimAlpha: CGFloat = 0.2
    let opaqueAlpha: CGFloat = 1.0
    
    let maxNumberOfPenalties = 3
    var currentNumberOfPenalties = 0 {
        didSet {
            updatePenalties()
        }
    }
    
    var gameTimer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "gameTick", userInfo: nil, repeats: true)
        
        // Set drop target for food and heart to be the monster
        heartButton.dropTarget = monsterImage
        foodButton.dropTarget = monsterImage
        
        // Set initial opacity for penalties
        penalty1Image.alpha = dimAlpha
        penalty2Image.alpha = dimAlpha
        penalty3Image.alpha = dimAlpha
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
    }
    
    // 
    func gameTick() {
        currentNumberOfPenalties += 1
        
        if currentNumberOfPenalties >= maxNumberOfPenalties {
            creatureDies()
            gameTimer?.invalidate()
        }
    }
    
    func creatureDies() {
        monsterImage.playDeathAnimation()
        
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "creatureRevives", userInfo: nil, repeats: false)
    }

    func creatureRevives() {
        monsterImage.playReviveAnimation()
    }
    
    func itemDroppedOnCharacter(notification: NSNotification) {
        print("Item dropped")
    }
    
    func updatePenalties() {
        penalty3Image.alpha = (currentNumberOfPenalties >= 3) ? opaqueAlpha : dimAlpha
        penalty2Image.alpha = (currentNumberOfPenalties >= 2) ? opaqueAlpha : dimAlpha
        penalty1Image.alpha = (currentNumberOfPenalties >= 1) ? opaqueAlpha : dimAlpha
    }

}

