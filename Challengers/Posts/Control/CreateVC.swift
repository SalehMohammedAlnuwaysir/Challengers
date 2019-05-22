//
//  CreateVC.swift
//  Challengers
//
//  Created by Saleh on 22/01/1440 AH.
//  Copyright © 1440 YAZEED NASSER. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
class CreateVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var dbRef: DatabaseReference = Database.database().reference()
    
    //@IBOutlet weak var ChooseCHCategoryLabel: UILabel!
    @IBOutlet weak var CHsCategoriesPicker: UIPickerView!
    @IBOutlet weak var CHCategoriesBtn: UIButton!
    var CHCategoryVal = "Football"
    var numOfPlayers:Int = 0
    @IBOutlet weak var CHName: UITextField!
    @IBOutlet weak var BestTimeLabel: UILabel!
    @IBOutlet weak var AnyTimeLabel: UILabel!
    @IBOutlet weak var FromTimeLabel: UILabel!
    @IBOutlet weak var ToTimeLabel: UILabel!
    @IBOutlet weak var AnyTimeSwitch: UISwitch!
    @IBOutlet weak var NavigationBar: UINavigationBar!
    
    /*@IBOutlet weak var FromTimePicker: UIPickerView!//
     @IBOutlet weak var ToTimePicker: UIPickerView!*/
    var cityVal:String = "Riyadh"
    @IBOutlet weak var TheCityLabel: UILabel!
    @IBOutlet weak var TheCityPicker: UIPickerView!
    @IBOutlet weak var TeamSegment: UISegmentedControl!
    @IBOutlet weak var NoOfPlayersLabel: UILabel!
    @IBOutlet weak var NoOfPlayersValue: UILabel!
    @IBOutlet weak var NoOfPlayersStepper: UIStepper!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var DescriptionField: UITextField!
    @IBOutlet weak var WhatsAppLinkLabel: UILabel!
    @IBOutlet weak var WhatsAppLinkField: UITextField!
    @IBOutlet weak var FromTimePicker: UIDatePicker!
    @IBOutlet weak var ToTimePicker: UIDatePicker!
    @IBOutlet weak var Create: UIButton!
    @IBOutlet weak var categoryBtn: UIButton!
    @IBOutlet weak var errorLbl: UILabel!
    
    
    
    let CHCategory = [ "Football", "Basketball", "Volleyball", "Baloot", "Video games", "Phone games", "Other"]
    let cities = ["Riyadh", "Jeddah","Dammam", "Al-Khobar", "Dhahran", "Al-Ahsa", "Qatif", "Jubail", "Taif", "Tabouk", "Abha", "Al Baha", "Jizan", "Najran", "Hail", "Makkah AL-Mukkaramah", "AL-Madinah Al-Munawarah", "Al Qaseem", "Jouf", "Yanbu"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //styles
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        Create.backgroundColor = GoButtenColor
        categoryBtn.backgroundColor = OptionButtenColor
        
        
        
        CHsCategoriesPicker.dataSource = self
        CHsCategoriesPicker.delegate = self
        TheCityPicker.dataSource = self
        TheCityPicker.delegate = self
        CHsCategoriesPicker.layer.cornerRadius = 7
        FromTimePicker.layer.cornerRadius = 7
        ToTimePicker.layer.cornerRadius = 7
        TheCityPicker.layer.cornerRadius = 7
        NoOfPlayersValue.layer.cornerRadius = 7
        BestTimeLabel.isHidden = false
        AnyTimeLabel.isHidden = false
        AnyTimeSwitch.isHidden = false
        
        //AnyTimeSwitch must be (on) coz the time picker will not be shown to the user at the begining
        AnyTimeSwitch.isOn = true
        FromTimeLabel.isHidden = true
        ToTimeLabel.isHidden = true
        FromTimePicker.isHidden = true
        ToTimePicker.isHidden = true
        
        TheCityLabel.isHidden = false
        TheCityPicker.isHidden = false
        TeamSegment.isHidden = false
        NoOfPlayersLabel.isHidden = false
        NoOfPlayersValue.isHidden = false
        NoOfPlayersStepper.isHidden = false
        DescriptionLabel.isHidden = false
        DescriptionField.isHidden = false
        WhatsAppLinkLabel.isHidden = false
        WhatsAppLinkField.isHidden = false
        
        //checking  butens and pickers
        CHCategoriesBtn.isHidden = false
        CHsCategoriesPicker.isHidden = true
        
        NavigationBar.setBackgroundImage(UIImage(), for: .default)
        NavigationBar.isTranslucent = true
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AnyTimeSwitchAction(_ sender: UISwitch) {
        if (sender.isOn == true) {
            FromTimeLabel.isHidden = true
            ToTimeLabel.isHidden = true
            FromTimePicker.isHidden = true
            ToTimePicker.isHidden = true
        } else {
            FromTimeLabel.isHidden = false
            ToTimeLabel.isHidden = false
            FromTimePicker.isHidden = false
            ToTimePicker.isHidden = false
        }
    }
    
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func CHCattegoriesPressed(_ sender: Any) {
        CHCategoriesBtn.isHidden = true
        CHsCategoriesPicker.isHidden = false
    }
    
    @IBAction func creatBtnPressed(_ sender: Any) {
        
        
        //all input Variables
        var owner:String!
        var ownerUsername: String!
        var nameOfGame:String!
        var category:String
        var Time:time
        var NumOfTeams:Int
        var Team:team
        
        var _NumOfPlayers:Int
        var city:String!
        var WhatsAppGroupLink:String
        var description:String
        var InputIsRedyToWrite = false
        
        //get user input
        owner = (Auth.auth().currentUser?.uid)!
        ownerUsername = usercurrentAcc._userName
        nameOfGame = CHName.text != nil ? CHName.text! : "" //chek after checking the category **!! (Hint)
        category = CHCategoriesBtn.titleLabel!.text!
        
        //anyTime OR spacificTime?
        if(AnyTimeSwitch.isOn == false){//spacificTime
            let Fhh = FromTimePicker.date.getHourMinute().hour
            let Fmm = FromTimePicker.date.getHourMinute().minute
            let Thh = ToTimePicker.date.getHourMinute().hour
            let Tmm = ToTimePicker.date.getHourMinute().minute
            Time = time(timetype: "Spasific", fromTimeHH: Fhh, fromTimeMM: Fmm, toTimeHH: Thh, toTimeMM: Tmm)
        }else{//anyTime
            Time = time(timetype: "Any Time", fromTimeHH: 0, fromTimeMM: 0, toTimeHH: 0, toTimeMM: 0)
        }
        // 0(me vs team : one team)  /  1( 1team vs 2team : two teams)
        NumOfTeams = Int(TeamSegment.selectedSegmentIndex) + 1 //the index starts from 0 ,Sol: fix by adding-> (+1)
        _NumOfPlayers = self.numOfPlayers
        
        switch category {
        case "Baloot":
            _NumOfPlayers = 2
            break;
        case "Video games":
            _NumOfPlayers = 1
            break;
        case "Phone games":
            _NumOfPlayers = 1
            break;

        default: break
            
        }
        
        Team = team.init(NumOFTeams: NumOfTeams, NumOFPlayers: _NumOfPlayers, playersT1IDs: [usercurrentAcc._uid:usercurrentAcc._uid], playersT2IDs: [:] )

        city = cityVal
        WhatsAppGroupLink = WhatsAppLinkField.text != nil ? WhatsAppLinkField.text! : ""
        description = DescriptionField.text != nil ? DescriptionField.text! : ""
        
        //start chicking the input of the user
        if(owner != "" && ownerUsername != "" && category != ""){
            if(nameOfGame != ""){
                InputIsRedyToWrite = true
            }else { self.showErorr(reson: "Enter the name of the game!") }
        }//else Show Error
        
        // Write in the firebase
        if (InputIsRedyToWrite){
            // write in DB
          
            let teamData = [
                "NumOfTeams" : Team._NumOFTeams,
                "NumOFPlayers":Team._NumOFPlayers,
                "playersT1IDs": Team._playersT1IDs,
                ] as [String:Any]
       
            let timeData = [
                "timetype" : Time._timetype,
                "fromTimeHH" : Time._fromTimeHH,
                "fromTimeMM" : Time._fromTimeMM,
                "toTimeHH" : Time._toTimeHH,
                "toTimeMM" : Time._toTimeMM
                ] as [String:Any]
            
            let ChallengeData = [
                //CHID  (Hint)**** will be the heading of the chall in the FBDB
                "ownerId" : owner,
                "ownerUsername" : ownerUsername,
                "nameOfGame" : nameOfGame,
                "category" : category,
                "city" : city,
                "WhatsAppGroupLink" : WhatsAppGroupLink,
                "description" : description,
                "time" : timeData,
                "team" : teamData
                ] as [String:Any]
            
            let newChalAutoId:String = self.dbRef.child("Challenges").childByAutoId().key
            self.dbRef.child("Challenges").child(newChalAutoId).setValue(ChallengeData)
        self.dbRef.child("Accounts").child(usercurrentAcc._uid).child("myChall").child(newChalAutoId).setValue(newChalAutoId)
            
            //notefication
            let content = UNMutableNotificationContent()
            content.title = "New challenge mabay you'd like :)"
            content.body = nameOfGame
            content.badge = 0
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 9, repeats: false)
            let request = UNNotificationRequest(identifier: "TimeFinish", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
            
            //add to FBDB
            
            self.dbRef.child("Accounts").observe(.childAdded) { (snapshot : DataSnapshot) in
                if let dict = snapshot.value as? [String : Any] {
                    let UserlId = snapshot.key as String
                    
                    if (UserlId != "" && UserlId !=  usercurrentAcc._uid){
                        
                        let _intrest = dict["intrest"] as! String
                        let _bestTime = dict["bestTime"] as! String
                        let _city = dict["city"] as! String
                        
                        print (UserlId)
                        print ("^^^^^^^^^^________________^^^^^^^^^^")
                        print (_intrest)
                        print (category)
                        print (Time._timetype)
                        print (Time._FromTimeIsAt)
                        print (_city)
                        print (city)
                        print (_bestTime)
                        
                        
                        
                        if(_intrest == category  && _city == city){
                            
                            if(Time._timetype == "Spasific" && _bestTime != "Any Time"){
                                 if(_bestTime == Time._FromTimeIsAt || _bestTime == Time._toTimeIsAt){
                                    self.dbRef.child("Accounts").child(UserlId).child("myNotify").child(newChalAutoId).setValue(newChalAutoId)
                                }
                            }else  if(Time._timetype == "Any Time" && _bestTime == "Any Time"){
                                self.dbRef.child("Accounts").child(UserlId).child("myNotify").child(newChalAutoId).setValue(newChalAutoId)
                            }
      
                        }//end adding to myNotify
                        
                        
                    }
                }
            }
            
            //end notefication
            
            
            self.dismiss(animated: true, completion: nil)
            
        }
        
        
    }
    func addNewCategryToDB(cate:String){}
    
    
    
    
    @IBAction func NoOfPlayersStepper(_ sender: UIStepper) {
        numOfPlayers = Int(sender.value)
        NoOfPlayersValue.text = String(numOfPlayers)
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == CHsCategoriesPicker) {
            let titleRow = CHCategory[row]
            
            return titleRow
            
        } else if (pickerView == TheCityPicker) {
            let titleRow = cities[row]
            
            return titleRow
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var toRet : Int = self.CHCategory.count
        if (pickerView == TheCityPicker){
            toRet = self.cities.count
        }
        return toRet
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //ChooseCHCategory.text = CHCategory[row]
        AnyTimeSwitchAction(AnyTimeSwitch)
        if (pickerView == CHsCategoriesPicker) {
            if CHCategory[row] == "" {
                
                BestTimeLabel.isHidden = true
                AnyTimeLabel.isHidden = true
                FromTimeLabel.isHidden = true
                ToTimeLabel.isHidden = true
                AnyTimeSwitch.isHidden = true
                FromTimePicker.isHidden = true
                ToTimePicker.isHidden = true
                TheCityLabel.isHidden = true
                TheCityPicker.isHidden = true
                TeamSegment.isHidden = true
                NoOfPlayersLabel.isHidden = true
                NoOfPlayersValue.isHidden = true
                NoOfPlayersStepper.isHidden = true
                DescriptionLabel.isHidden = true
                DescriptionField.isHidden = true
                WhatsAppLinkLabel.isHidden = true
                WhatsAppLinkField.isHidden = true
                AnyTimeSwitchAction(AnyTimeSwitch)
            } else if (CHCategory[row] == "Football" || CHCategory[row] == "Basketball" || CHCategory[row] == "Volleyball" || CHCategory[row] == "Baloot") {
                BestTimeLabel.isHidden = false
                AnyTimeLabel.isHidden = false
                FromTimeLabel.isHidden = true
                ToTimeLabel.isHidden = true
                AnyTimeSwitch.isHidden = false
                FromTimePicker.isHidden = true
                ToTimePicker.isHidden = true
                TheCityLabel.isHidden = false
                TheCityPicker.isHidden = false
                TeamSegment.isHidden = false
                if CHCategory[row] == "Baloot" {
                    
                    NoOfPlayersLabel.isHidden = true
                    NoOfPlayersValue.isHidden = true
                    NoOfPlayersStepper.isHidden = true
                } else {
                    
                    NoOfPlayersLabel.isHidden = false
                    NoOfPlayersValue.isHidden = false
                    NoOfPlayersStepper.isHidden = false
                }
                
                DescriptionLabel.isHidden = false
                DescriptionField.isHidden = false
                WhatsAppLinkLabel.isHidden = false
                WhatsAppLinkField.isHidden = false
                AnyTimeSwitchAction(AnyTimeSwitch)
            } else if CHCategory[row] == "Video games" || CHCategory[row] == "Phone games" {
                
                
                BestTimeLabel.isHidden = false
                AnyTimeLabel.isHidden = false
                FromTimeLabel.isHidden = true
                ToTimeLabel.isHidden = true
                AnyTimeSwitch.isHidden = false
                FromTimePicker.isHidden = true
                ToTimePicker.isHidden = true
                TheCityLabel.isHidden = true
                TheCityPicker.isHidden = true
                TeamSegment.isHidden = true
                NoOfPlayersLabel.isHidden = true
                NoOfPlayersValue.isHidden = true
                NoOfPlayersStepper.isHidden = true
                DescriptionLabel.isHidden = false
                DescriptionField.isHidden = false
                WhatsAppLinkLabel.isHidden = false
                WhatsAppLinkField.isHidden = false
                AnyTimeSwitchAction(AnyTimeSwitch)
            } else if CHCategory[row] == "Other" {
                
                
                BestTimeLabel.isHidden = false
                AnyTimeLabel.isHidden = false
                FromTimeLabel.isHidden = true
                ToTimeLabel.isHidden = true
                AnyTimeSwitch.isHidden = false
                FromTimePicker.isHidden = true
                ToTimePicker.isHidden = true
                TheCityLabel.isHidden = true
                TheCityPicker.isHidden = true
                TeamSegment.isHidden = true
                NoOfPlayersLabel.isHidden = true
                NoOfPlayersValue.isHidden = true
                NoOfPlayersStepper.isHidden = true
                DescriptionLabel.isHidden = false
                DescriptionField.isHidden = false
                WhatsAppLinkLabel.isHidden = false
                WhatsAppLinkField.isHidden = false
                AnyTimeSwitchAction(AnyTimeSwitch)
            }
            
            CHCategoriesBtn.setTitle(String(CHCategory[row]), for: UIControlState.normal)
            
            CHCategoryVal = String(CHCategory[row])
            
            CHCategoriesBtn.isHidden = false
            CHsCategoriesPicker.isHidden = true
            
        }
        cityVal = String(cities[row])
    }
    //showErorr
    func showErorr(reson:String ){
        Create.shake()
        errorLbl.text = reson
        UIView.animate(withDuration: 2, animations: {
            self.errorLbl.alpha = 8
        })
        UIView.animate(withDuration: 2, animations: {
            self.errorLbl.alpha = 0
        })
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
