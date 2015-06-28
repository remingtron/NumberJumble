//
//  SecondsToTimeFormatter.swift
//  NumberJumble
//
//  Created by Remington Davenport on 6/28/15.
//  Copyright (c) 2015 Remington Davenport. All rights reserved.
//

import Foundation

public class SecondsToTimeFormatter {
    
    public class func convert(toConvert: Int, showZeroMinutes: Bool = true) -> String {
        let seconds = toConvert % 60
        let minutes = (toConvert-seconds) / 60
        let secondsString = String(format: "%02d", seconds)
        let minutesString = minutes == 0 && !showZeroMinutes ? "" : "\(minutes)"
        return "\(minutesString):\(secondsString)"
    }
    
}
