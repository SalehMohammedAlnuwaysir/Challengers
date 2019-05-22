//
//  challenge.swift
//  Challengers
//
//  Created by YAZEED NASSER on 11/10/2018.
//  Copyright © 2018 YAZEED NASSER. All rights reserved.
//

import Foundation
class challenge{
    var _challId: String!
    var _ownerId: String!
    var _ownerUsername: String!
    var _nameOfGame:String!
    var _category:String!
    var _Time:time!//  anyTime OR spacificTime
    var _Team:team!
    var _city:String!
    var _WhatsAppGroupLink:String?
    var _description:String?
 
    init(challId:String,ownerId: String,ownerUsername: String,nameOfGame:String,category:String,Time:time,Team:team,city:String,WhatsAppGroupLink:String,description:String){
        _challId = challId
        _ownerId = ownerId
        _ownerUsername = ownerUsername
        _nameOfGame = nameOfGame
        _category = category
        _Time = Time
        _Team = Team
        _city = city
        _WhatsAppGroupLink = WhatsAppGroupLink
        _description = description
    }
}
