//
//  Time.swift
//  Challengers
//
//  Created by YAZEED NASSER on 14/10/2018.
//  Copyright © 2018 YAZEED NASSER. All rights reserved.
//

import Foundation

class time{
    var _timetype:String // AnyTimee or Spasific
    
    var _fromTimeHH:Int
    var _fromTimeMM:Int
    
    var _toTimeHH:Int
    var _toTimeMM:Int
    
    //to use in the itrests of other users (notify)
    var _toTimeIsAt:String
    var _FromTimeIsAt:String
    
    
    
    init(timetype:String,fromTimeHH:Int,fromTimeMM:Int,toTimeHH:Int,toTimeMM:Int){
        _timetype = timetype
        if(timetype == "Spasific"){
            _fromTimeHH = fromTimeHH
            _fromTimeMM = fromTimeMM
            _toTimeHH = toTimeHH
            _toTimeMM = toTimeMM
            _FromTimeIsAt = getWhatTimeIsAt(TimeHH: fromTimeHH,TimeMM: fromTimeMM)
            _toTimeIsAt = getWhatTimeIsAt(TimeHH: fromTimeHH,TimeMM: fromTimeMM)
        }else{
            _fromTimeHH = 0
            _fromTimeMM = 0
            _toTimeHH = 0
            _toTimeMM = 0
            _FromTimeIsAt = ""
            _toTimeIsAt = ""
            _timetype = "Any Time"
            
        }
    }
    
}

func getWhatTimeIsAt(TimeHH:Int,TimeMM:Int) -> String{
    //return afternoon,....
    //MM ont used to make it easy (maby it'll be used in the futuer)
    
    if(TimeHH>=0 && TimeHH<=11){
        return "Morning"
    }
    else if(TimeHH>=12 && TimeHH<=17){
        return "Afternoon"
    }
    else{
        return "Evening"
    }
}
