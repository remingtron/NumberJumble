//
//  ConfigureViewControllerSpec.swift
//  NumberJumble
//
//  Created by Remington Davenport on 6/28/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

import Nimble
import Quick
import NumberJumble
import SpriteKit

class ConfigureViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        describe("end view controller") {
            var underTest: ConfigureViewController!
            let window = UIWindow(frame: UIScreen().bounds)
            
            beforeEach {
                underTest = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("configureController") as! ConfigureViewController
                window.rootViewController = underTest
                window.makeKeyAndVisible()
            }
            
            it("starts a new game when play button is pressed") {
                underTest.playButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
                expect(underTest.presentedViewController).to(beAKindOf(GameViewController))
            }
            
            it("sets the game length when play button is pressed") {
                underTest.gameLengthStepper.value = 120
                underTest.playButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
                let gameViewController = underTest.presentedViewController as! GameViewController
                expect(gameViewController.gameLength).to(equal(120))
            }
            
            describe("game length stepper") {
                
                it("has minimum value of 10") {
                    expect(underTest.gameLengthStepper.minimumValue).to(equal(10))
                }
                
                it("has maximum value of 300") {
                    expect(underTest.gameLengthStepper.maximumValue).to(equal(300))
                }
                
                it("has step value of 10") {
                    expect(underTest.gameLengthStepper.stepValue).to(equal(10))
                }
                
            }
            
            it("updates the game length label text when stepper value changes") {
                underTest.gameLengthStepper.value = 230
                underTest.gameLengthValueChange("")
                expect(underTest.gameLengthLabel.text).to(equal("3:50"))
            }
            
            it("handles whole minutes") {
                underTest.gameLengthStepper.value = 240
                underTest.gameLengthValueChange("")
                expect(underTest.gameLengthLabel.text).to(equal("4:00"))
            }
            
            it("shows 0 minutes") {
                underTest.gameLengthStepper.value = 40
                underTest.gameLengthValueChange("")
                expect(underTest.gameLengthLabel.text).to(equal("0:40"))
            }
        }
        
    }
    
}