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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "creatureDies", userInfo: nil, repeats: false)
        
        heartButton.dropTarget = monsterImage
        foodButton.dropTarget = monsterImage
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
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

}

