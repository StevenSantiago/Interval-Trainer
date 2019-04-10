//
//  Timer.swift
//  Interval Trainer
//
//  Created by Steven on 10/28/18.
//  Copyright © 2018 Steven Santiago. All rights reserved.
//

import Foundation

struct Timers {
    var name:String
    var restTime:Int
    var activeTime:Int
    var sets:Int
    
    init(name:String,restTime:Int,activeTime:Int,sets:Int) {
        self.name = name
        self.restTime = restTime
        self.activeTime = activeTime
        self.sets = sets
    }
    
    mutating func subtractSet() {
        sets = sets - 1
    }
    
    func convertToHoursMinsSeconds(Seconds:Int) -> (Int,Int,Int) {
        var hours:Int = 0
        var minutes = Int(Seconds/60)
        var seconds:Int = 0
        
        if(Seconds >= 3600){
            //Hours
            hours = 1
        }
        if(Seconds >= 60){
            //Minutes
            minutes = Int(Seconds/60)
            
            seconds = Seconds % 60
        } else {
            seconds = Int(Seconds)
        }
        
        return (hours,minutes,seconds)
    }
    
    static func convertToSeconds(h:Int,m:Int,s:Int) -> Int{
        return Int(s + m*60 + h*3600)
    }
    
}
