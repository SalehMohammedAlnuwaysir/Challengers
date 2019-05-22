//
//  EditProfile.swift
//  Challengers
//
//  Created by Saleh on 08/02/1440 AH.
//  Copyright © 1440 YAZEED NASSER. All rights reserved.
//

import UIKit
import Firebase

class EditProfileVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    var ref: DatabaseReference = Database.database().reference()
    var GlobaleProfileVC: ProfileVC?

   
    @IBOutlet weak var userNameTxt: UITextField!
    
    var intrestVal = ""
    let intrestsArr:[String] = ["Football", "Basketball", "Volleyball", "Baloot", "Video games", "Phone games", "Other"]
    @IBOutlet weak var intrestBtn: UIButton!
    @IBOutlet weak var intrestPik: UIPickerView!
    
    var bestTimeVal = ""
    let betsTimeArr:[String] = ["Any Time","morning","afternoon","eveninig"]
    @IBOutlet weak var bestTimeBtn: UIButton!
    @IBOutlet weak var bestTimePik: UIPickerView!
    
    var citiesVal = ""
    let citiesArr:[String] = ["Riyadh", "Jeddah"," Dammam", "Al-Khobar", "Dhahran", "Al-Ahsa", "Qatif", "Jubail", "Taif", "Tabouk", "Abha", "Al Baha", "Jizan", "Najran", "Hail", "Makkah AL-Mukkaramah", "AL-Madinah Al-Munawarah", "Al Qaseem", "Jouf", "Yanbu"]
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var cityPik: UIPickerView!
    
    @IBOutlet weak var SaveBtn: UIButton!
    @IBOutlet weak var CancelBtn: UIButton!
    @IBOutlet weak var errorLbl: UILabel!
    var activityView:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTxt.text! = usercurrentAcc._userName as String
        userNameTxt.backgroundColor = UIColor.white
        let leftView = UILabel(frame: CGRect(x: 10, y: 0, width: 7, height: 26))
        userNameTxt.leftView = leftView
        userNameTxt.leftViewMode = .always
        userNameTxt.contentVerticalAlignment = .center
        userNameTxt.alpha = 0.9
        userNameTxt.layer.cornerRadius = 12
        userNameTxt.layer.shadowColor = UIColor.darkGray.cgColor
        userNameTxt.layer.shadowOffset = CGSize(width: 0, height: 6)
        userNameTxt.layer.shadowRadius = 5
        intrestBtn.backgroundColor = OptionButtenColor
        bestTimeBtn.backgroundColor = OptionButtenColor
        cityBtn.backgroundColor = OptionButtenColor
        intrestPik.dataSource = self
        intrestPik.delegate = self
        bestTimePik.dataSource = self
        bestTimePik.delegate = self
        cityPik.dataSource = self
        cityPik.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func intrestBtnPressed(_ sender: Any) {
        intrestBtn.isHidden = true
        intrestPik.isHidden = false
    }
    @IBAction func bestTimeBtnPressed(_ sender: Any) {
        bestTimeBtn.isHidden = true
        bestTimePik.isHidden = false
    }
    @IBAction func cityBtnPressed(_ sender: Any) {
        cityBtn.isHidden = true
        cityPik.isHidden = false
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        //self.performSegue(withIdentifier: "ProfileVC", sender: usercurrentAcc)
        let userName:String = userNameTxt.text!
        let intrest:String = intrestVal
        let bestTime:String = bestTimeVal
        let city:String = citiesVal
        if (userName != "" && intrest != "" && bestTime != "" && city != "") {
            let userInformation = ["bestTime" : bestTime, "city" : city, "email" : usercurrentAcc._email, "intrest" : intrest, "passWord" : usercurrentAcc._passWord , "uid": usercurrentAcc._uid, "userName" :  userName]
            self.ref.child("Accounts").child( (Auth.auth().currentUser?.uid)! ).setValue(userInformation)
            let userAccount = account.init(email: usercurrentAcc._email ,userName: userName ,passWord: usercurrentAcc._passWord ,intrest: intrest, bestTime: bestTime, city: city, favouriteCHs: [], uid : "")
            usercurrentAcc = userAccount
            GlobaleProfileVC?.updateProfileView()
            self.dismiss(animated: true, completion: nil)

        } else {
            showErorr(reson: "Enter all informatin below!")
        }
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
 
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == intrestPik {
            return intrestsArr.count
        } else if pickerView == bestTimePik {
            return betsTimeArr.count
        } else if pickerView == cityPik {
            return citiesArr.count
        } else {
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == intrestPik {
            return String(intrestsArr[row])
        } else if pickerView == bestTimePik {
            return String(betsTimeArr[row])
        } else if pickerView == cityPik {
            return String(citiesArr[row])
        } else {
            return ""
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == intrestPik {
            intrestBtn.setTitle(String(intrestsArr[row]), for: UIControlState.normal)
            intrestVal = String(intrestsArr[row])
            intrestPik.isHidden = true
            intrestBtn.isHidden = false
        } else if pickerView == bestTimePik {
            bestTimeBtn.setTitle(String(betsTimeArr[row]), for: UIControlState.normal)
            bestTimeVal = String(betsTimeArr[row])
            bestTimePik.isHidden = true
            bestTimeBtn.isHidden = false
        } else if pickerView == cityPik {
            cityBtn.setTitle(String(citiesArr[row]), for: UIControlState.normal)
            citiesVal = String(citiesArr[row])
            cityPik.isHidden = true
            cityBtn.isHidden = false
        }
    }
    //func to show error
    func showErorr(reson:String ){
        SaveBtn.shake()
        errorLbl.text = reson
        UIView.animate(withDuration: 2, animations: {
            self.errorLbl.alpha = 8
        })
        UIView.animate(withDuration: 2, animations: {
            self.errorLbl.alpha = 0
        })
        
    }
   

}
