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
    var hour:Int // hours,minutes and seconds might be redudant fields. Look into this
    var minute:Int
    var second:Int
    var restTime:Int
    var activeTime:Int
    var currentRunTime:Int
    var sets:Int
    
    init(name:String,hour:Int,minute:Int,second:Int,restTime:Int,activeTime:Int,currentRunTime:Int,sets:Int) {
        self.name = name
        self.hour = hour
        self.minute = minute
        self.second = second
        self.restTime = restTime
        self.activeTime = activeTime
        self.currentRunTime = currentRunTime
        self.sets = sets
    }
    
    
    mutating func subtractRunTime(){
        currentRunTime = currentRunTime - 1
    }
    
    mutating func subtractSet() {
        sets = sets - 1
    }
    
    mutating func resetActiveTime(){
        currentRunTime = activeTime
    }
    
    mutating func resetRestTime(){
        currentRunTime = restTime
    }
    
    mutating func endOfSession(){
        currentRunTime = 0
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
    
    func convertToSeconds(h:Int,m:Int,s:Int) -> Int{
        return Int(s + m*60 + h*60*60)
    }
}
