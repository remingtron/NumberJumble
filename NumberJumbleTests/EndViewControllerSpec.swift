//
//  EndViewControllerSpec.swift
//  NumberJumble
//
//  Created by Remington Davenport on 6/15/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

import Nimble
import Quick
import NumberJumble
import SpriteKit

class EndViewControllerSpec: QuickSpec {

    override func spec() {
    
        describe("end view controller") {
            let underTest = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("endController") as! EndViewController
            let window = UIWindow(frame: UIScreen().bounds)
            
            beforeEach {
                window.rootViewController = underTest
                window.makeKeyAndVisible()
            }
            
            class UIViewControllerForTest: UIViewController {
                
                var didDismissWithoutAnimation = false
                
                private override func dismissViewControllerAnimated(flag: Bool, completion: (() -> Void)?) {
                    if flag == false {
                        didDismissWithoutAnimation = true
                    }
                }
            }
            
            // TODO: not sure why this test doesn't work, or how to get presentingViewController populated in a unit test
            xit("returns to configure screen/back two screens when play again button is touched") {
                let firstViewController = UIViewControllerForTest()
                let secondViewController = UIViewController()
                
                window.rootViewController = firstViewController
                firstViewController.presentViewController(secondViewController, animated: false, completion: nil)
                secondViewController.presentViewController(underTest, animated: false, completion: nil)
                
                underTest.playAgainButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
                expect(firstViewController.didDismissWithoutAnimation).to(equal(true))
            }
        }
        
    }
    
}
