//
//  RegisterVC.swift
//  Challengers
//
//  Created by YAZEED NASSER on 23/09/2018.
//  Copyright © 2018 YAZEED NASSER. All rights reserved.
//

import UIKit
import Firebase

class RegesterVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    //database ref
    var dbRef: DatabaseReference = Database.database().reference()
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPwdTxt: UITextField!
    
    var intrestVal = ""
    let intrestsArr:[String] = ["Football", "Basketball", "Volleyball", "Baloot", "Video games", "Phone games", "Other"]
    @IBOutlet weak var intrestBtn: UIButton!
    @IBOutlet weak var intrestPik: UIPickerView!
    
    var bestTimeVal = ""
    let betsTimeArr:[String] = ["Any Time","Morning","Afternoon","Evening"]
    @IBOutlet weak var bestTimeBtn: UIButton!
    @IBOutlet weak var bestTimePik: UIPickerView!
    
    var citiesVal = ""
    let citiesArr:[String] = ["Riyadh", "Jeddah","Dammam", "Al-Khobar", "Dhahran", "Al-Ahsa", "Qatif", "Jubail", "Taif", "Tabouk", "Abha", "Al Baha", "Jizan", "Najran", "Hail", "Makkah AL-Mukkaramah", "AL-Madinah Al-Munawarah", "Al Qaseem", "Jouf", "Yanbu"]
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var cityPik: UIPickerView!
    
    @IBOutlet weak var regesterBtn: UIButton!
    @IBOutlet weak var CancelBtn: UIButton!
    @IBOutlet weak var BGDarkView: UIView!
    var activityView:UIActivityIndicatorView!
    @IBOutlet weak var NavigationBar: UINavigationBar!
    
    @IBOutlet weak var erorrLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        intrestBtn.backgroundColor = OptionButtenColor
        bestTimeBtn.backgroundColor = OptionButtenColor
        cityBtn.backgroundColor = OptionButtenColor
        regesterBtn.backgroundColor = GoButtenColor
        CancelBtn.backgroundColor = BackButtenColor
        
        //acctiveity for the Register
        activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityView.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        activityView.frame = CGRect(x: 0, y: 0, width: 500.0, height: 500.0)
        activityView.center  = CGPoint(x: (view.frame.width/2), y: (view.frame.height/2))
        
        //activityView.center = loginBtn.center
        BGDarkView.addSubview(activityView)
        
        // Do any additional setup after loading the view.
        intrestPik.dataSource = self
        intrestPik.delegate = self
        bestTimePik.dataSource = self
        bestTimePik.delegate = self
        cityPik.dataSource = self
        cityPik.delegate = self
        
        NavigationBar.setBackgroundImage(UIImage(), for: .default)
        NavigationBar.isTranslucent = true
        
        // Welcome, check if the gitignore file works
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //fix it!!
    @IBAction func cancelBtnPressed
        (_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
    
    @IBAction func regesterBtnPressed(_ sender: Any) {
        let email:String = emailTxt.text!
        let userName:String = userNameTxt.text!
        let password:String = passwordTxt.text!
        let confirmPwd:String = confirmPwdTxt.text!
        let intrest:String = intrestVal
        let bestTime:String = bestTimeVal
        let city:String = citiesVal
        //chek input
        if (email != "" && userName != "" && password != "" && confirmPwd != "" && intrest != "" && bestTime != "" && city != "") {
            if (password != confirmPwd) {
                showErorr(reson: "password does not match the confirm password")
            } else {
                let userAccount = account.init(email: email ,userName: userName ,passWord: password ,intrest: intrest, bestTime: bestTime, city: city, favouriteCHs: [],  uid : "")
                //chek if in the DB?
                if false {
                    //in the DB
                    //Show thw Erorr
                } else {
                    //segue >> home
                    self.authAccRegister(acc: userAccount)
                    //                self.performSegue(withIdentifier: "HomeVC", sender: userAccount)
                }
            }
        }else{
            showErorr(reson: "Enter all informatin below!")
            
        }
        
    }
    //Firebase Funcs vvv
    func authAccRegister(acc:account) {
        
        //start activity & disable buttens & enabel darkView
        self.setRegisterAndCancelButton(enabled: false)
        activityView.startAnimating()
        
        Auth.auth().createUser(withEmail: acc._email, password: acc._passWord) { user, error in
            if error == nil && user != nil {
                print("Account created!")
            
                
                let data = [
                    "uid" : (Auth.auth().currentUser?.uid)!,
                    "email" : acc._email,
                    "userName" : acc._userName,
                    "passWord" : acc._passWord,
                    "intrest" : acc._intrest,
                    "bestTime" : acc._bestTime,
                    "city" : acc._city,
                    
                    //for other VCs vvvvv
                    "myChalls" : [],//"ChallId:String"
                    "myFave" : [],  //"ChallId:String"
                    "myJoins" : [], //"ChallId:String"
                    "myNotify" : [] //"isNotified:Bool","ChallId:String"
                    
                    ] as [String:Any]
                
                acc._uid = (Auth.auth().currentUser?.uid)!
                self.dbRef.child("Accounts").child( (Auth.auth().currentUser?.uid)! ).setValue(data)
                account.setAccInfo(acc: acc)
                
                //stop activity & enabel buttens & disabel darkView
                self.activityView.stopAnimating()
                self.setRegisterAndCancelButton(enabled: true)
                
                self.performSegue(withIdentifier: "HomeVC", sender: acc)
                
            } else {
                if "\(error!.localizedDescription)" == "Network error (such as timeout, interrupted connection or unreachable host) has occurred."{
                    self.showErorr(reson: "Check your connection bro ;)")
                }else{
                    self.showErorr(reson: "\(error!.localizedDescription)")
                    
                }
                
                //stop activity & enabel buttens & disabel darkView
                self.activityView.stopAnimating()
                self.setRegisterAndCancelButton(enabled: true)
            }
        }
    }
    //func to show error
    func showErorr(reson:String ){
        regesterBtn.shake()
        erorrLbl.text = reson
        UIView.animate(withDuration: 2, animations: {
            self.erorrLbl.alpha = 8
        })
        UIView.animate(withDuration: 2, animations: {
            self.erorrLbl.alpha = 0
        })
        
    }
    //signin button & cancel buttn (disable/enable)
    func setRegisterAndCancelButton(enabled:Bool) {
        if enabled {
            BGDarkView.isHidden = true
            regesterBtn.alpha = 1.0
            regesterBtn.isEnabled = true
            CancelBtn.alpha = 1.0
            CancelBtn.isEnabled = true
        } else {
            BGDarkView.isHidden = false
            regesterBtn.alpha = 0.5
            regesterBtn.isEnabled = false
            CancelBtn.alpha = 0.5
            CancelBtn.isEnabled = false
        }
    }
    //pikers code
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
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
    
    //segue (nevgating to the home page)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destnation = segue.destination as? HomeVC {
            if let account = sender as? account{
                destnation._account = account
            }
            
        }
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
