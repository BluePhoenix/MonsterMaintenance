//
//  ViewController.swift
//  MonsterMaintenance
//
//  Created by Felix Barros on 12/12/15.
//  Copyright © 2015 Bits That Matter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var monsterImage: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var foodButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var arrayOfImages = [UIImage]()
        for i in 1...4 {
            if let image = UIImage(named: "idle (\(i)).png") {
                arrayOfImages.append(image)
            }
        }
        monsterImage.animationImages = arrayOfImages
        monsterImage.animationDuration = 0.8
        monsterImage.animationRepeatCount = 0
        monsterImage.startAnimating()
    }


}

