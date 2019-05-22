//
//  myChallengCell.swift
//  Challengers
//
//  Created by YAZEED NASSER on 23/11/2018.
//  Copyright © 2018 YAZEED NASSER. All rights reserved.
//

import UIKit

class myChallengCell: UITableViewCell {
    var Chall:challenge!
    
    @IBOutlet weak var contantBoxView: UIView!
    @IBOutlet weak var titelLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var categoryLbbl: UILabel!
    @IBOutlet weak var fromTimeLbl: UILabel!
    @IBOutlet weak var toTimeLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var t1Lbl: UILabel!
    @IBOutlet weak var t2Lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contantBoxView.layer.cornerRadius = 10
        dropShadow(a: contantBoxView)
        updateViewCell()
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
        categoryLbbl.text = "Category: \(Chall._category!)"
        cityLbl.text = Chall._city!
        //time
        if Chall._Time._timetype == "Spasific"{
         
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
            fromTimeLbl.text = "the time"
            toTimeLbl.text = "isn't Spasified"
        }
        let NumberOfPLayers:Int = Chall._Team._NumOFPlayers
        
        if Chall._Team._NumOFTeams == 2 {
            let NumPlayersJiundT1:Int = Chall._Team._playersT1IDs.count
            let NumPlayersJiundT2:Int = Chall._Team._playersT2IDs.count
            
            print("Join T1 [\(NumberOfPLayers)/\(NumPlayersJiundT1)]")
            print("Join T1 [\(NumberOfPLayers)/\(NumPlayersJiundT2)]")
            
            let team1Txt = "[\(NumberOfPLayers)/\(NumPlayersJiundT1)]"
            let team2Txt = "[\(NumberOfPLayers)/\(NumPlayersJiundT2)]"
            t1Lbl.text = team1Txt
            t2Lbl.text = team2Txt
            
        }else if Chall._Team._NumOFTeams == 1 {
            let NumPlayersJiundT2:Int = Chall._Team._playersT2IDs.count
            print("Join T1 [\(NumberOfPLayers)/\(NumPlayersJiundT2)]")
            let team2Txt = "[\(NumberOfPLayers)/\(NumPlayersJiundT2)]"
            t2Lbl.text = team2Txt
        }
            
        
            
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
