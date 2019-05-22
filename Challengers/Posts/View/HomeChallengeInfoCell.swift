//
//  HomeChallengeInfoCell.swift
//  Challengers
//
//  Created by YAZEED NASSER on 09/11/2018.
//  Copyright © 2018 YAZEED NASSER. All rights reserved.
//

import UIKit
import Firebase

class HomeChallengeInfoCell: UITableViewCell {
    var Chall:challenge!
    var joind:Bool = false
    
    @IBOutlet weak var BGImage: UIImageView!
    @IBOutlet weak var BGImageFrontView: UIView!
    @IBOutlet weak var contantBoxView: UIView!
    @IBOutlet weak var titelLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var ownerLbl: UILabel!
    @IBOutlet weak var categoryLbbl: UILabel!
    @IBOutlet weak var fromTimeLbl: UILabel!
    @IBOutlet weak var toTimeLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var team1Btn: RoundedBtn!
    
    @IBOutlet weak var team2Btn: RoundedBtn!
    
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var favedLbl: UILabel!
    @IBOutlet weak var team1Lbl: UILabel!
    @IBOutlet weak var team2Lbl: UILabel!
    
    @IBOutlet weak var yourChalLbl: UILabel!
    
    
    var favBtnStatus = false
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        // Initialization code
        BGImage.layer.cornerRadius = 5
        BGImageFrontView.layer.cornerRadius = 5
        contantBoxView.layer.cornerRadius = 10
        dropShadow(a: contantBoxView)
        dropShadow(a: BGImageFrontView)
        updateViewCell()
        
        checkifFavBefor()
        chekIfTisYours()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func checkifFavBefor(){
        if Chall == nil{return}
        //default senario
        favBtnStatus = false
        favBtn.isHidden = false
        favedLbl.isHidden = true
        
        favBtn.backgroundColor = UIColor.lightGray
        for i in myFaveChallIds{
            if(i == Chall._challId){
                favBtn.backgroundColor = UIColor.yellow
                favBtnStatus = true
                favBtn.isHidden = true
                favedLbl.isHidden = false
                return
            }
        }
    }
    
    func chekIfTisYours(){
        if Chall == nil{return}

        yourChalLbl.isHidden = true

        if Chall._ownerId == usercurrentAcc._uid{
            team1Lbl.isHidden = true
            team2Lbl.isHidden = true
            team1Btn.isHidden = true
            team2Btn.isHidden = true
            
            //show the owner labbel
            yourChalLbl.isHidden = false


        }
    }
    
    func dropShadow(a:UIView) {
        a.layer.masksToBounds = false
        a.layer.shadowColor = UIColor.black.cgColor
        a.layer.shadowOpacity = 0.5
        a.layer.shadowOffset = CGSize(width: -1, height: 1)
        a.layer.shadowRadius = 1
        
    }
    func updateViewCell(){
        if Chall == nil{return}
        
        titelLbl.text = Chall._nameOfGame!
        descriptionLbl.text = Chall._description!
        ownerLbl.text = "By: \(Chall._ownerUsername!)"
        categoryLbbl.text = "Category: \(Chall._category!)"
        cityLbl.text = Chall._city!
        //time
        if Chall._Time._timetype == "Spasific"{
            /*let fhh = String(Chall._Time._fromTimeHH)
             let fmm = String(Chall._Time._fromTimeMM)
             let thh = String(Chall._Time._toTimeHH)
             let tmm = String(Chall._Time._toTimeMM)*/
            
            var DBFHH: String!
            var DBFMM: String!
            var DBTHH: String!
            var DBTMM: String!
            
            // to fix: One Deget Time situation Ex(2:6 => 02:06)
            if (Chall._Time._fromTimeHH < 10) {
                DBFHH = "0\(Chall._Time._fromTimeHH)"
            } else {
                DBFHH = "\(Chall._Time._fromTimeHH)"
            }
            
            if (Chall._Time._fromTimeMM < 10) {
                DBFMM = "0\(Chall._Time._fromTimeMM)"
            } else {
                DBFMM = "\(Chall._Time._fromTimeMM)"
            }
            
            if (Chall._Time._toTimeHH < 10) {
                DBTHH = "0\(Chall._Time._toTimeHH)"
            } else {
                DBTHH = "\(Chall._Time._toTimeHH)"
            }
            
            if (Chall._Time._toTimeMM < 10) {
                DBTMM = "0\(Chall._Time._toTimeMM)"
            } else {
                DBTMM = "\(Chall._Time._toTimeMM)"
            }
            //end fix>
            
            let fhh = String(DBFHH)
            let fmm = String(DBFMM)
            let thh = String(DBTHH)
            let tmm = String(DBTMM)
            
            fromTimeLbl.text = "From \(fhh):\(fmm)"
            toTimeLbl.text = "To \(thh):\(tmm)"
        }else{
            fromTimeLbl.text = "The Owner'll"
            toTimeLbl.text = "Spasify The Time"
        }
        
        //teams
        team1Btn.isHidden = true
        team2Btn.isHidden = true
        team1Lbl.isHidden = true
        team2Lbl.isHidden = true
        
        if Chall._Team._NumOFTeams == 2 {
            team1Btn.isHidden = false
            team2Btn.isHidden = false
            team1Lbl.isHidden = false
            team2Lbl.isHidden = false
            
        }else{
            team2Btn.isHidden = false
            team2Lbl.isHidden = false
            
        }
        updateTeamBtnLbl()
        chekIfTisYours()
    }
    
    func updateTeamBtnLbl(){
        chekIfJoined()
        team1Btn.isEnabled = true
        team2Btn.isEnabled = true
        team1Btn.alpha = 1
        team2Btn.alpha = 1
        
        descriptionLbl.isHidden = false
        
        if Chall._description == ""{
            descriptionLbl.isHidden = true
        }
        
        
        let NumberOfPLayers:Int = Chall._Team._NumOFPlayers
        
        if Chall._Team._NumOFTeams == 2 {
            let NumPlayersJiundT1:Int = Chall._Team._playersT1IDs.count
            let NumPlayersJiundT2:Int = Chall._Team._playersT2IDs.count
            
            print("Join T1 [\(NumberOfPLayers)/\(NumPlayersJiundT1)]")
            print("Join T1 [\(NumberOfPLayers)/\(NumPlayersJiundT2)]")
            
            let team1Txt = "[\(NumberOfPLayers)/\(NumPlayersJiundT1)]"
            let team2Txt = "[\(NumberOfPLayers)/\(NumPlayersJiundT2)]"
            
            self.team1Lbl.text = team1Txt
            self.team2Lbl.text = team2Txt
            //team1 disaple Btn
            if NumberOfPLayers <= NumPlayersJiundT1  {
                team1Btn.isEnabled = false
                team1Btn.alpha = 0.3
                team1Lbl.text = "Full"
            }else if joind{
                team1Btn.isEnabled = false
                team1Btn.alpha = 0.3
                team1Lbl.text = "joined"
            }
            //team2 disaple Btn
            if NumberOfPLayers <= NumPlayersJiundT2  {
                team2Btn.isEnabled = false
                team2Btn.alpha = 0.3
                team2Lbl.text = "Full"
                
            }else if joind{
                team2Btn.isEnabled = false
                team2Btn.alpha = 0.3
                team2Lbl.text = "joined"
            }
            
            
        }else{// so it only one team needed
            let NumPlayersJiundT1:Int = Chall._Team._playersT1IDs.count
            
            print("Join T1 [\(NumberOfPLayers)/\(NumPlayersJiundT1)]")
            
            let team1Txt = "[\(NumberOfPLayers)/\(NumPlayersJiundT1)]"
            team1Lbl.text = team1Txt
            //team1 disaple Btn
            if NumberOfPLayers <= NumPlayersJiundT1  {
                team2Btn.isEnabled = false
                team2Btn.alpha = 0.3
                team2Lbl.text = "Full"
            }else if joind{
                team2Btn.isEnabled = false
                team2Btn.alpha = 0.3
                team2Lbl.text = "joined"
            }
        }
    }
    
    func chekIfJoined(){
        let currentAccId = usercurrentAcc._uid
        print(usercurrentAcc._uid)
        //team 1
        for i in Chall._Team._playersT1IDs {
            
            if i.value == currentAccId && currentAccId != "" && i.value != ""{
                joind = true
            }
        }
        //team 2
        for i in Chall._Team._playersT2IDs {
            if i.value == currentAccId && currentAccId != "" && i.value != ""{
                joind = true
            }
        }
        
    }
    
    
    
    @IBAction func joinT1BBtnPressed(_ sender: Any) {
        //add to the team list
    Database.database().reference().child("Challenges").child(Chall._challId).child("team").child("playersT1IDs").child(usercurrentAcc._uid).setValue(usercurrentAcc._uid)
        
        //add to account joined challs joined
    Database.database().reference().child("Accounts").child(usercurrentAcc._uid).child("myJoined").child(Chall._challId).setValue(Chall._challId)
        
        Chall._Team._playersT1IDs[usercurrentAcc._uid] = usercurrentAcc._uid
        self.updateTeamBtnLbl()
    }
    @IBAction func joinT2BBtnPressed(_ sender: Any) {
        //add to the team list
        Database.database().reference().child("Challenges").child(Chall._challId).child("team").child("playersT2IDs").child(usercurrentAcc._uid).setValue(usercurrentAcc._uid)
   //add to account joined challs joined
        Database.database().reference().child("Accounts").child(usercurrentAcc._uid).child("myJoined").child(Chall._challId).setValue(Chall._challId)
        
        Chall._Team._playersT2IDs[usercurrentAcc._uid] = usercurrentAcc._uid
        self.updateViewCell()
    }
    
    
 
    @IBAction func favBtn(_ sender: Any) {
        if(!favBtnStatus){//Not in the fav
            favBtnStatus = true
            favBtn.isHidden = true
            favedLbl.isHidden = false
            myFaveChallIds.append(Chall._challId)
        Database.database().reference().child("Accounts").child(usercurrentAcc._uid).child("myFave").child(Chall._challId).setValue(Chall._challId)
            
            favBtn.backgroundColor = UIColor.yellow

        }else if (favBtnStatus){//in the fav
            favBtnStatus = false
            favBtn.isHidden = false
            favedLbl.isHidden = true
            
            //remove from myFaveChallIds Arr
            for i in 0..<myFaveChallIds.count{
                if myFaveChallIds[i] == Chall._challId{
                    myFaveChallIds.remove(at: i)
                    break;
                }
            }//end loop
            
            //remove from DBFB
        Database.database().reference().child("Accounts").child(usercurrentAcc._uid).child("myFave").child(Chall._challId).removeValue()
        favBtn.backgroundColor = UIColor.lightGray

        }
    }
    
    
    
}


