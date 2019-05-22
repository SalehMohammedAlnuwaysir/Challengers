//
//  ProfileVC.swift
//  Challengers
//
//  Created by Saleh on 26/01/1440 AH.
//  Copyright © 1440 YAZEED NASSER. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth


class ProfileVC: UIViewController {
    var whatToLoad:String = "myChall"
    //var MyChallIds =  [String]()
    var myChalls = [challenge]()
    
    //var myJoinedChallIds = [String]()
    var myJoinedChall = [challenge]()
    
    //var myFaveChallIds = [String]()
    var myFaveChall = [challenge]()
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var NavigationBar: UINavigationBar!
    var ref: DatabaseReference = Database.database().reference()
    
    @IBOutlet weak var MyChallengesBtn: UIButton!
    @IBOutlet weak var JoinedChallengesBtn: UIButton!
    @IBOutlet weak var favBtn: UIButton!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var intrestLbl: UILabel!
    @IBOutlet weak var bestTimeLbl: UILabel!
    @IBOutlet weak var cityLb1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        updateProfileView()
        MyChallengesBtn.backgroundColor = (UIColor.orange)
        JoinedChallengesBtn.backgroundColor = (UIColor.lightGray)
        favBtn.backgroundColor = (UIColor.lightGray)
        tableView.dataSource = self
    
        NavigationBar.setBackgroundImage(UIImage(), for: .default)
        NavigationBar.isTranslucent = true
        
        
        //Strat the prations
        loadChallenges()
        getChallenges()
      
        
        self.nameLbl.backgroundColor = UIColor.yellow
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    func CheckChallenges(_ ChId:String,_ ChArrIds:[String])->Bool {
        
        let numOfIdesToCompear = ChArrIds.count
        for i in 0..<numOfIdesToCompear {
            if ChId == ChArrIds[i]{
                return true
            }
        }//end loop
        
        return false
        
    }
    
    func loadChallenges(){
        
        
       let ref = Database.database().reference()
        //loadMyChall
        ref.child("Accounts").child(usercurrentAcc._uid).child("myChall").observe(.childAdded) { (snapshot : DataSnapshot) in
            MyChallIds.append(snapshot.key as String)
        }
        //loaMyJoined
        ref.child("Accounts").child(usercurrentAcc._uid).child("myJoined").observe(.childAdded) { (snapshot : DataSnapshot) in
            myJoinedChallIds.append(snapshot.key as String)
        }
        //loadMyFave
        ref.child("Accounts").child(usercurrentAcc._uid).child("myFave").observe(.childAdded) { (snapshot : DataSnapshot) in
            myFaveChallIds.append(snapshot.key as String)
        }
    }
   
   
    func getChallenges() {
        myChalls = []
        myJoinedChall = []
        myFaveChall = []
        
        for i in 0..<allChallenges.count{
            //myJoinedChall
            if CheckChallenges(allChallenges[i]._challId,myJoinedChallIds) {
                myJoinedChall.append(allChallenges[i])
            }
            //myFaveChall
            if CheckChallenges(allChallenges[i]._challId,myFaveChallIds) {
                myFaveChall.append(allChallenges[i])
            }
            //myChalls
            if CheckChallenges(allChallenges[i]._challId,MyChallIds) {
                myChalls.append(allChallenges[i])
            }
        }//end llop
        
            self.tableView.reloadData()
        
        loadChallenges()

    }
 
    
    @IBAction func favBtnPressed(_ sender: Any) {
        favBtn.backgroundColor = (UIColor.orange)
        MyChallengesBtn.backgroundColor =  (UIColor.lightGray)
        JoinedChallengesBtn.backgroundColor = (UIColor.lightGray)
        whatToLoad = "myFave"
        self.getChallenges()

    }
    @IBAction func MyChallengesBtnPressed(_ sender: UIButton) {
        
        MyChallengesBtn.backgroundColor = (UIColor.orange)
        JoinedChallengesBtn.backgroundColor = (UIColor.lightGray)
        favBtn.backgroundColor =  (UIColor.lightGray)
        whatToLoad = "myChall"
        self.getChallenges()
    }
    @IBAction func JoinedChallengesBtnPressed(_ sender: UIButton) {
        JoinedChallengesBtn.backgroundColor = (UIColor.orange)
        MyChallengesBtn.backgroundColor = (UIColor.lightGray)
        favBtn.backgroundColor =  (UIColor.lightGray)
        whatToLoad = "myJoinsChall"
        self.getChallenges()

    }
    @IBAction func logoutBtnPressed(_ sender: Any) {
         try! Auth.auth().signOut()
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    
    //update profileView information
    func updateProfileView(){
        
        //updating profile labels with the profile info from the (global obj of CurrentProfileInfo) => usercurrentAcc
        nameLbl.text! = "    Your name: \( usercurrentAcc._userName as String),\(usercurrentAcc._uid as String)"
        emailLbl.text! = "    Your email: \(usercurrentAcc._email as String)"
        intrestLbl.text! = "    Intrest in: \(usercurrentAcc._intrest as String)"
        bestTimeLbl.text! = "    Your best time: \(usercurrentAcc._bestTime as String)"
        cityLb1.text! = "    City: \(usercurrentAcc._city as String)"
    }
    
    //update profileView information from EditProfile.swift
    func updateProfileView(acc:account){
        nameLbl.text! = "    Your name: \( acc._userName as String)"
        emailLbl.text! = "    Your email: \(acc._email as String)"
        intrestLbl.text! = "    Intrest in: \(acc._intrest as String)"
        bestTimeLbl.text! = "    Your best time: \(acc._bestTime as String)"
        cityLb1.text! = "    City: \(acc._city as String)"
    }

    
    @IBAction func EditBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "EditProfileVC", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destnation = segue.destination as? EditProfileVC {
            if let profileVCObj = sender as? ProfileVC{
                destnation.GlobaleProfileVC = profileVCObj
            }
        }
    }

}
//
extension ProfileVC: UITableViewDataSource { //need to fix the new

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(whatToLoad == "myChall") && (myChalls.count != 0){
            return myChalls.count
            }
        else if (whatToLoad == "myJoinsChall") && (myJoinedChall.count != 0){
            return myJoinedChall.count
        }
        else if (whatToLoad == "myFave") && (myFaveChall.count != 0){
            return myFaveChall.count
        }
        whatToLoad = "noting"
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if whatToLoad == "myChall" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "myChallengCell", for: indexPath) as! myChallengCell
            cell.Chall = myChalls[indexPath.row]
            cell.awakeFromNib()
            return cell
        }
        else if whatToLoad == "myJoinsChall" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "joinedChallengCell", for: indexPath) as! joinedChallengCell
            cell.Chall = myJoinedChall[indexPath.row]
            cell.awakeFromNib()
            return cell
        }
        else if whatToLoad == "myFave" {//fave cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCallengeInfoCell", for: indexPath) as! FavouriteCallengeInfoCell
            cell.Chall = myFaveChall[indexPath.row]
            cell.awakeFromNib()
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "nothingFoundCell", for: indexPath)
        return cell
        

    }
}
