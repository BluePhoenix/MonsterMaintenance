//
//  ViewController.swift
//  MonsterMaintenance
//
//  Created by Felix Barros on 12/12/15.
//  Copyright © 2015 Bits That Matter. All rights reserved.
//

import UIKit
import AVFoundation

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
            // Ensure greater than 0
            currentNumberOfPenalties = max(0, currentNumberOfPenalties)
        }
    }
    
    var currentNeed = 0 {
        didSet {
            updateNeeds()
        }
    }
    var monsterIsHappy = true
    var gameTimer: NSTimer?

    var musicPlayer: AVAudioPlayer?
    var soundEffectFood: AVAudioPlayer?
    var soundEffectHeart: AVAudioPlayer?
    var soundEffectSkull: AVAudioPlayer?
    var soundEffectDeath: AVAudioPlayer?
    
    let secondsBetweenNeeds = 4.0
    let secondsUntilRevival = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadAudioPlayers()
        
        musicPlayer?.play()
        
        currentNeed = -1
        startGameTimer()
        
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
        if !monsterIsHappy {
            currentNumberOfPenalties += 1
            soundEffectSkull?.play()
        }
        monsterIsHappy = false
        
        generateRandomNeed()
        
        if currentNumberOfPenalties >= maxNumberOfPenalties {
            currentNeed = -1
            creatureDies()
        }
    }
    
    func creatureDies() {
        currentNeed = -1
        soundEffectDeath?.play()
        monsterImage.playDeathAnimation()
        gameTimer?.invalidate()
        
        NSTimer.scheduledTimerWithTimeInterval(secondsUntilRevival, target: self, selector: "creatureRevives", userInfo: nil, repeats: false)
    }
    
    func creatureIdle() {
        monsterImage.playIdleAnimation()
    }

    func creatureRevives() {
        monsterImage.playReviveAnimation()
        currentNumberOfPenalties = 0
        currentNeed = -1
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "startGameTimer", userInfo: nil, repeats: false)
    }
    
    func itemDroppedOnCharacter(notification: NSNotification) {
        switch currentNeed {
        case 0:
            soundEffectHeart?.play()
            break
        case 1:
            soundEffectFood?.play()
            break
        default:
            break
        }
        
        print("Item dropped, penalties: \(currentNumberOfPenalties)")
        gameTimer?.invalidate()
        currentNumberOfPenalties -= 1
        currentNeed = -1
        monsterIsHappy = true
        
        startGameTimer()
    }
    
    func startGameTimer() {
        monsterImage.playIdleAnimation()
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(secondsBetweenNeeds, target: self, selector: "gameTick", userInfo: nil, repeats: true)
    }
    
    func generateRandomNeed() {
        currentNeed = Int(arc4random_uniform(UInt32(2)))
    }
    
    func updateNeeds() {
        heartButton.alpha = (currentNeed == 0) ? opaqueAlpha : dimAlpha
        foodButton.alpha = (currentNeed == 1) ? opaqueAlpha : dimAlpha
        
        heartButton.userInteractionEnabled = (currentNeed == 0)
        foodButton.userInteractionEnabled = (currentNeed == 1)
    }
    
    func updatePenalties() {
        penalty3Image.alpha = (currentNumberOfPenalties >= 3) ? opaqueAlpha : dimAlpha
        penalty2Image.alpha = (currentNumberOfPenalties >= 2) ? opaqueAlpha : dimAlpha
        penalty1Image.alpha = (currentNumberOfPenalties >= 1) ? opaqueAlpha : dimAlpha
    }
    
    func loadAudioPlayers() {
        loadPlayer(&self.musicPlayer, fileName: "cave-music", fileType: "mp3", volume: 0.2)
        loadPlayer(&self.soundEffectFood, fileName: "bite", fileType: "wav", volume: 0.4)
        loadPlayer(&self.soundEffectHeart, fileName: "heart", fileType: "wav", volume: 0.4)
        loadPlayer(&self.soundEffectDeath, fileName: "death", fileType: "wav", volume: 0.4)
        loadPlayer(&self.soundEffectSkull, fileName: "skull", fileType: "wav", volume: 0.4)
    }
    
    func loadPlayer(inout player: AVAudioPlayer?, fileName: String, fileType: String, volume: Float = 1.0) {
        do {
            if let pathString = NSBundle.mainBundle().pathForResource(fileName, ofType: fileType) {
                let fileURL = NSURL(fileURLWithPath: pathString)
                try player = AVAudioPlayer(contentsOfURL: fileURL)
                player?.volume = volume
                player?.prepareToPlay()
            }
        } catch let error as NSError {
            print("Error loading player: \(error.debugDescription)")
        }
    }

}

