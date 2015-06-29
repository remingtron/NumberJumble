//
//  HelpViewController.swift
//  NumberJumble
//
//  Created by Remington Davenport on 6/28/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

import UIKit

public class HelpViewController: UIViewController {
    
    @IBAction func backButtonTouchUpInside(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

}
