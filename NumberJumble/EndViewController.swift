//
//  EndViewController.swift
//  NumberJumble
//
//  Created by Remington Davenport on 6/6/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

import UIKit

public class EndViewController: UIViewController {
    
    @IBOutlet public weak var finalScoreLabel: UILabel!
    @IBOutlet public weak var playAgainButton: UIButton!
    
    private var finalScore = 0
    
    public func setFinalScore(score: Int) {
        finalScore = score
    }
    
    public override func viewDidLoad() {
        finalScoreLabel.text = "Final Score: \(finalScore)"
    }
    
    @IBAction func playAgainButtonTouchUpInside(sender: AnyObject) {
        let gameViewControlller = self.presentingViewController!
        let configureViewController = gameViewControlller.presentingViewController!
        configureViewController.dismissViewControllerAnimated(false, completion: nil)
    }
    
}
