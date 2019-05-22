//
//  NotificationsVC.swift
//  Challengers
//
//  Created by Saleh on 26/01/1440 AH.
//  Copyright © 1440 YAZEED NASSER. All rights reserved.
//

import UIKit
import Firebase
class NotificationsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var notifChallList = [challenge]()
    var whatToLoad = "noResult"
    var refresher: UIRefreshControl!
    
    @IBOutlet weak var NavigationBar: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        NavigationBar.setBackgroundImage(UIImage(), for: .default)
        NavigationBar.isTranslucent = true
        // Do any additional setup after loading the view.
        
        //for refreshe
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh!")
        refresher.addTarget(self, action: #selector(NotificationsVC.getChallenges), for: UIControlEvents.valueChanged )
        tableView.addSubview(refresher)
        
        getChallenges()
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
    
    @objc func loadChallenges(){
        myNotifyChallIds = []
        Database.database().reference().child("Accounts").child(usercurrentAcc._uid).child("myNotify").observe(.childAdded) { (snapshot : DataSnapshot) in
            //check if there ??
            myNotifyChallIds.append(snapshot.key)
        }
    }
    
    @objc func getChallenges(){
        notifChallList = []
        for i in 0..<allChallenges.count{
            //myJoinedChall
            if CheckChallenges(allChallenges[i]._challId,myNotifyChallIds) {
                notifChallList.append(allChallenges[i])
            }
        }
        self.tableView.reloadData()
        loadChallenges()

        refresher.endRefreshing()
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

extension NotificationsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if ( notifChallList.count != 0){
            whatToLoad = "Notify"
            return notifChallList.count
            

        }

        whatToLoad = "noResult"
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(whatToLoad == "Notify"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeChallengeInfoCell", for: indexPath) as! HomeChallengeInfoCell
            
            cell.Chall = notifChallList[indexPath.row]
            cell.awakeFromNib()
            return cell
        }
        
        // no Result
        let cell = tableView.dequeueReusableCell(withIdentifier: "nothingFoundCell", for: indexPath)
        return cell
    }
}

