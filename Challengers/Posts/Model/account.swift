//
//  Account.swift
//  Challengers
//
//  Created by YAZEED NASSER on 23/09/2018.
//  Copyright © 2018 YAZEED NASSER. All rights reserved.
//

import Foundation
import Firebase

// global obj of CurrentProfileInfo => usercurrentAcc
var usercurrentAcc:account = account(email:"" , userName:"", passWord:"", intrest:"", bestTime:"", city:"",favouriteCHs: [], uid:"")

class account{
    var _uid: String!
    var _email:String!
    var _userName:String!
    var _passWord:String!
    var _intrest:String!
    var _bestTime:String!
    var _city:String!
    var _favouriteCHs:[String]!
    
    init(email:String , userName:String, passWord:String, intrest:String, bestTime:String, city:String, favouriteCHs:[String], uid:String) {
        _uid = uid
        _email = email
        _userName = userName
        _passWord = passWord
        _intrest = intrest
        _bestTime = bestTime
        _city = city
        _favouriteCHs = favouriteCHs
    }
    
    static func setAccInfo(acc:account){
        usercurrentAcc._uid = acc._uid
        usercurrentAcc._email = acc._email
        usercurrentAcc._userName = acc._userName
        usercurrentAcc._passWord = acc._passWord
        usercurrentAcc._intrest = acc._intrest
        usercurrentAcc._bestTime = acc._bestTime
        usercurrentAcc._city = acc._city
    }
    
    func updateAcc(){
        Database.database().reference().child("Accounts").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value, with: { snapshot in
            if  let dect = snapshot.value as? [String:Any],
                let _userName = dect["userName"] as? String,
                let _password = dect["passWord"] as? String,
                let _email = dect["email"] as? String,
                let _intrest = dect["intrest"] as? String,
                let _bestTime = dect["bestTime"] as? String,
                let _city = dect["city"] as? String,
                let _uid = dect["uid"] as? String
            {
                let accountOfTheUser:account! = account.init(email: _email,userName: _userName,passWord: _password,intrest: _intrest,bestTime: _bestTime , city: _city, favouriteCHs: [], uid : _uid)
                usercurrentAcc = accountOfTheUser
            }
    
        })
    }
}

