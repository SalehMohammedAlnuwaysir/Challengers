//
//  FilterVC.swift
//  Challengers
//
//  Created by Saleh on 19/03/1440 AH.
//  Copyright © 1440 YAZEED NASSER. All rights reserved.
//

import UIKit
import Firebase

class FilterVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var ref: DatabaseReference = Database.database().reference()
    var GlobaleHomeVC: HomeVC?
    @IBOutlet weak var CHsCategoriesPicker: UIPickerView!
    @IBOutlet weak var CHCategoriesBtn: UIButton!
    @IBOutlet weak var SaveBtn: UIButton!
    @IBOutlet weak var CancelBtn: UIButton!
    @IBOutlet weak var removeFilBtn: UIButton!
    
    var category:String = "Football"
  
    var CHCategoryVal = "Football"
    let CHCategory = [ "Football", "Basketball", "Volleyball", "Baloot", "Video games", "Phone games", "Other"]
    @IBOutlet weak var categoryBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if GlobaleHomeVC?.FilVal != "..." {
            category = GlobaleHomeVC!.FilVal
        }
        categoryBtn.backgroundColor = OptionButtenColor
        CHsCategoriesPicker.dataSource = self
        CHsCategoriesPicker.delegate = self
        CHsCategoriesPicker.layer.cornerRadius = 7
        CHCategoriesBtn.isHidden = false
        CHsCategoriesPicker.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CHCattegoriesPressed(_ sender: Any) {
        CHCategoriesBtn.isHidden = true
        CHsCategoriesPicker.isHidden = false
        category = CHCategoriesBtn.titleLabel!.text!
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == CHsCategoriesPicker) {
            let titleRow = CHCategory[row]
            return titleRow
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //ChooseCHCategory.text = CHCategory[row]
        if (pickerView == CHsCategoriesPicker) {
            CHCategoriesBtn.setTitle(String(CHCategory[row]), for: UIControlState.normal)
            CHCategoryVal = String(CHCategory[row])
            CHCategoriesBtn.isHidden = false
            CHsCategoriesPicker.isHidden = true
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.CHCategory.count
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        
        print(CHCategoryVal)
        GlobaleHomeVC?.FilVal = CHCategoryVal as String
        GlobaleHomeVC?.FilLbl.text = "\(GlobaleHomeVC?.FilVal as! String)"
        //GlobaleHomeVC?.loadFilterChallenges(text: category)
        GlobaleHomeVC?.loadChallenges()
        
        if ((GlobaleHomeVC?.searchTxtVal) != ""){
        GlobaleHomeVC?.cancelSearchBtn.isHidden = false
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func removFilBBtnPressed(_ sender: Any) {
        GlobaleHomeVC?.FilVal = "..."
        GlobaleHomeVC?.FilLbl.text = "\(GlobaleHomeVC?.FilVal as! String)"
        GlobaleHomeVC?.cancelSearchBtnPressed(self)
        GlobaleHomeVC?.loadChallenges()
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
