//
//  ConfigureViewController.swift
//  NumberJumble
//
//  Created by Remington Davenport on 6/28/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

import UIKit

public class ConfigureViewController: UIViewController {
    
    @IBOutlet public weak var gameLengthLabel: UILabel!
    @IBOutlet public weak var gameLengthStepper: UIStepper!
    @IBOutlet public weak var playButton: UIButton!
    
    @IBAction public func gameLengthValueChange(sender: AnyObject) {
        let currentValue = Int(gameLengthStepper.value)
        let seconds = currentValue % 60
        let secondsString = seconds == 0 ? "00" : "\(seconds)"
        let minutes = (currentValue-seconds) / 60
        gameLengthLabel.text = "\(minutes):\(secondsString)"
    }
    
    @IBAction func touchUpInsidePlayButton(sender: AnyObject) {
        let gameController = storyboard!.instantiateViewControllerWithIdentifier("gameViewController") as! GameViewController
        gameController.gameLength = Int(gameLengthStepper.value)
        presentViewController(gameController, animated: true, completion: nil)
    }
}