//
//  NSDate.swift
//  Consolidate
//
//  Created by Conrad Koh on 26/3/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
extension TimeInterval
{
    func ToString() -> String{
        
        let ti = NSInteger(self)
        
        let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
        
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
    }
    
    func InHoursAndMinutes() -> String{
        let ti = NSInteger(self);
        let seconds = ti % 60
        let minutes = (ti / 60) % 60;
        let hours = (ti / 3600);
        if(hours > 0){
            return String(format: "%0.2d hrs %0.2d mins %0.2d secs",hours,minutes,seconds);
        }
        else{
            return String(format: "%0.2d mins %0.2d secs",minutes, seconds);
        }
    }
}
