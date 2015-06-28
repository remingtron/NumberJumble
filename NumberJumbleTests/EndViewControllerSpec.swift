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
            
            it("returns to configure screen when play again button is touched") {
                underTest.playAgainButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
                expect(underTest.presentedViewController).to(beAKindOf(ConfigureViewController))
            }
        }
        
    }
    
}
