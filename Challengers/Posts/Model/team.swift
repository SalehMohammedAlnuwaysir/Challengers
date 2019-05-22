//
//  Team.swift
//  Challengers
//
//  Created by YAZEED NASSER on 14/10/2018.
//  Copyright © 2018 YAZEED NASSER. All rights reserved.
//

import Foundation
class team {
    var _NumOFTeams:Int!
    var _NumOFPlayers:Int!
    var _playersT1IDs:[String:String] = [:]
    var _playersT2IDs:[String:String] = [:]
    
    init(NumOFTeams:Int,NumOFPlayers:Int,playersT1IDs:[String:String],playersT2IDs:[String:String]){
        _NumOFTeams = NumOFTeams
        _NumOFPlayers = NumOFPlayers
        _playersT1IDs = playersT1IDs
        _playersT2IDs = playersT2IDs
    }
    
}
