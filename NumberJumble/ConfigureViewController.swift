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
    @IBOutlet public weak var chainLengthScoringSwitch: UISwitch!
    
    @IBAction public func gameLengthValueChange(sender: AnyObject) {
        let currentValue = Int(gameLengthStepper.value)
        gameLengthLabel.text = SecondsToTimeFormatter.convert(currentValue)
    }
    
    @IBAction func touchUpInsidePlayButton(sender: AnyObject) {
        let gameController = storyboard!.instantiateViewControllerWithIdentifier("gameViewController") as! GameViewController
        gameController.gameLength = Int(gameLengthStepper.value)
        gameController.useChainLengthScoring = chainLengthScoringSwitch.on
        presentViewController(gameController, animated: true, completion: nil)
    }
}