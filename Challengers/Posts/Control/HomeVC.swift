//
//  HomeVC.swift
//  Challengers
//
//  Created by YAZEED NASSER on 23/09/2018.
//  Copyright © 2018 YAZEED NASSER. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

var GlobaleHomeVC: HomeVC?

var allChallenges = [challenge]()
var myJoinedChallIds = [String]()
var MyChallIds =  [String]()
var myFaveChallIds = [String]()
var myNotifyChallIds = [String]()



class HomeVC: UIViewController, UITextFieldDelegate {
    var _account:account! = account.init(email: "", userName: "", passWord: "", intrest: "", bestTime: "", city: "", favouriteCHs: [], uid: "")

    var whatToLoad:String = "Challs"
    var challsRadyToPrint = [challenge]()
    
    var FilVal = "..."
    @IBOutlet weak var FilLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTxt: UITextField!
    var searchTxtVal:String = ""
    @IBOutlet weak var cancelSearchBtn: RoundedBtn!
    @IBOutlet weak var NavigationBar: UINavigationBar!
    var refresher: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        FilLbl.text = "\(FilVal as String)"
        tableView.dataSource = self
        loadMyChallengesInfo()
        loadChallenges()
        
        NavigationBar.setBackgroundImage(UIImage(), for: .default)
        NavigationBar.isTranslucent = true
        GlobaleHomeVC = self
        
        //for refreshe
//        refresher = UIRefreshControl()
//        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh!")
//        refresher.addTarget(self, action: #selector(HomeVC.loadChallenges), for: UIControlEvents.valueChanged )
//        tableView.addSubview(refresher)
//
        
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cancelSearchBtnPressed(_ sender: Any) {
        searchTxt.resignFirstResponder()
        searchTxt.text = ""
        loadChallenges()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        searchTxt.resignFirstResponder()//will hide the keybord
        loadChallenges(text: String(searchTxt.text!))
        return true
    }
    
    
    
    func getAccInfo()->account{
        return self._account
    }
    
    func loadMyChallengesInfo(){//MyChall,MyFave,MyJoined
        MyChallIds = []
        myJoinedChallIds = []
        myFaveChallIds = []
        Database.database().reference().child("Accounts").child(usercurrentAcc._uid).child("myChall").observe(.childAdded) { (snapshot : DataSnapshot) in
            MyChallIds.append(snapshot.key)
        }
        Database.database().reference().child("Accounts").child(usercurrentAcc._uid).child("myJoined").observe(.childAdded) { (snapshot : DataSnapshot) in
            myJoinedChallIds.append(snapshot.key)
        }
        Database.database().reference().child("Accounts").child(usercurrentAcc._uid).child("myFave").observe(.childAdded) { (snapshot : DataSnapshot) in
            myFaveChallIds.append(snapshot.key)
        }
        Database.database().reference().child("Accounts").child(usercurrentAcc._uid).child("myNotify").observe(.childAdded) { (snapshot : DataSnapshot) in
            myNotifyChallIds.append(snapshot.key)
        }
    }
        
    @objc func loadChallenges() {
        searchTxtVal = ""
        allChallenges = []
        challsRadyToPrint = []

        Database.database().reference().child("Challenges").observe(.childAdded) { (snapshot : DataSnapshot) in
            if let dict = snapshot.value as? [String : Any] {
                let ChallId = snapshot.key
                let ownerId = dict["ownerId"] as! String
                let nameOfGame = dict["nameOfGame"] as! String
                let ownerUsername = dict["ownerUsername"] as! String
                
                let category = dict["category"] as! String
                let city = dict["city"] as! String
                let WhatsAppGroupLink = dict["WhatsAppGroupLink"] as! String
                let description = dict["description"] as! String
                
                let TimeDict = dict["time"] as! [String : Any]
                let timetype = TimeDict["timetype"] as! String
                let fromTimeHH = TimeDict["fromTimeHH"] as! Int
                let fromTimeMM = TimeDict["fromTimeMM"] as! Int
                let toTimeHH = TimeDict["toTimeHH"] as! Int
                let toTimeMM = TimeDict["toTimeMM"] as! Int
                
                let TeamDict = dict["team"] as! [String : Any]
                let NumOfTeams = TeamDict["NumOfTeams"] == nil ? 0 : TeamDict["NumOfTeams"] as! Int
                let NumOFPlayers = TeamDict["NumOFPlayers"] == nil ? 0 : TeamDict["NumOFPlayers"] as! Int
                //let playersT1IDs:[String:String] = (TeamDict["playersT1IDs"]
                let playersT1IDs:[String:String] = (TeamDict["playersT1IDs"]) == nil ? [:] : TeamDict["playersT1IDs"] as! [String:String]
                let playersT2IDs:[String:String] = (TeamDict["playersT2IDs"]) == nil ? [:] : TeamDict["playersT2IDs"] as! [String:String]
                
                let timeObj:time = time.init(timetype: timetype, fromTimeHH: fromTimeHH, fromTimeMM: fromTimeMM, toTimeHH: toTimeHH, toTimeMM: toTimeMM)
                let teamObj:team = team.init(NumOFTeams: NumOfTeams, NumOFPlayers: NumOFPlayers, playersT1IDs: playersT1IDs, playersT2IDs: playersT2IDs)
                
                let chall:challenge = challenge.init(challId: ChallId, ownerId: ownerId, ownerUsername: ownerUsername, nameOfGame: nameOfGame, category: category, Time: timeObj, Team: teamObj, city: city, WhatsAppGroupLink: WhatsAppGroupLink, description: description)
                
                allChallenges.append(chall)

                if(self.chekifFiltered(category)){
                self.challsRadyToPrint.append(chall)
                }
            }
            allChallenges.reverse()
            self.challsRadyToPrint.reverse()
            self.tableView.reloadData()

        }
//        allChallenges.reverse()
//        challsRadyToPrint.reverse()
//        self.tableView.reloadData()

        
        cancelSearchBtn.isHidden = true
    }
    
        
    func loadChallenges(text:String) { //theSearchFunc
        searchTxtVal = (searchTxt.text)!
        allChallenges = []
        challsRadyToPrint = []
        
        Database.database().reference().child("Challenges").observe(.childAdded) { (snapshot : DataSnapshot) in
            if let dict = snapshot.value as? [String : Any] {
                let nameOfGame = dict["nameOfGame"] as! String
                if ( nameOfGame.localizedStandardContains(text)){ //start of the search
                    let ChallId = snapshot.key
                    let ownerId = dict["ownerId"] as! String
                    
                    let ownerUsername = dict["ownerUsername"] as! String
                    
                    let category = dict["category"] as! String
                    let city = dict["city"] as! String
                    let WhatsAppGroupLink = dict["WhatsAppGroupLink"] as! String
                    let description = dict["description"] as! String
                    
                    let TimeDict = dict["time"] as! [String : Any]
                    let timetype = TimeDict["timetype"] as! String
                    let fromTimeHH = TimeDict["fromTimeHH"] as! Int
                    let fromTimeMM = TimeDict["fromTimeMM"] as! Int
                    let toTimeHH = TimeDict["toTimeHH"] as! Int
                    let toTimeMM = TimeDict["toTimeMM"] as! Int
                    
                    let TeamDict = dict["team"] as! [String : Any]
                    let NumOfTeams = TeamDict["NumOfTeams"] == nil ? 0 : TeamDict["NumOfTeams"] as! Int
                    let NumOFPlayers = TeamDict["NumOFPlayers"] == nil ? 0 : TeamDict["NumOFPlayers"] as! Int
                    let playersT1IDs:[String:String] = TeamDict["playersT1IDs"] != nil ?  TeamDict["playersT1IDs"] as! [String:String] : [:]
                    let playersT2IDs:[String:String] = TeamDict["playersT2IDs"] != nil ?  TeamDict["playersT2IDs"] as! [String:String] : [:]
                    
                    let timeObj:time = time.init(timetype: timetype, fromTimeHH: fromTimeHH, fromTimeMM: fromTimeMM, toTimeHH: toTimeHH, toTimeMM: toTimeMM)
                    let teamObj:team = team.init(NumOFTeams: NumOfTeams, NumOFPlayers: NumOFPlayers, playersT1IDs: playersT1IDs, playersT2IDs: playersT2IDs)
                    
                    let chall:challenge = challenge.init(challId: ChallId, ownerId: ownerId, ownerUsername: ownerUsername, nameOfGame: nameOfGame, category: category, Time: timeObj, Team: teamObj, city: city, WhatsAppGroupLink: WhatsAppGroupLink, description: description)
                    
                    allChallenges.append(chall)
                    
                    if(self.chekifFiltered(category)){
                        self.challsRadyToPrint.append(chall)
                    }
                    
                    
                }//end of the search
                allChallenges.reverse()
                self.challsRadyToPrint.reverse()
                self.tableView.reloadData()
            }
        }
//        allChallenges.reverse()
//        challsRadyToPrint.reverse()
//        self.tableView.reloadData()

        cancelSearchBtn.isHidden = false
    }
    
    

    
    @IBAction func FilterBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "FilterVC", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destnation = segue.destination as? FilterVC {
            if let HomeVCObj = sender as? HomeVC{
                destnation.GlobaleHomeVC = HomeVCObj
            }
        }
    }
    
    //this fucn will check if the filltert is enapels if so it check if not it'll ignor the check
    func chekifFiltered(_ filByCategor:String) -> Bool{
        if self.FilVal == "..." {//fillter is disapled
            return true
        }else{//fillter is enapled (now we need to check the category ;))
            if(self.FilVal == filByCategor){//category is same as the fillter
                return true
            }else{
                return false
            }
        }
    }
    
    
}

extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if ( challsRadyToPrint.count != 0){
            whatToLoad = "Challs"
        return challsRadyToPrint.count
    }
        whatToLoad = "noResult"
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(whatToLoad == "Challs"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeChallengeInfoCell", for: indexPath) as! HomeChallengeInfoCell
            
            cell.Chall = challsRadyToPrint[indexPath.row]
            cell.awakeFromNib()
            return cell
        }
        
        // no Result
        let cell = tableView.dequeueReusableCell(withIdentifier: "nothingFoundCell", for: indexPath)
        return cell
    }
}
