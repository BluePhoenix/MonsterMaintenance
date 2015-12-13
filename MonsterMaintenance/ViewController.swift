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
    }
    
    func creatureDies() {
        monsterImage.playDeathAnimation()
    }


}

