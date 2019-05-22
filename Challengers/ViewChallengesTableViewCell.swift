//
//  ViewChallengesTableViewCell.swift
//  BButton
//
//  Created by Saleh on 25/02/1440 AH.
//

import UIKit

class ViewChallengesTableViewCell: UITableViewCell {

    @IBOutlet weak var CNLbl: UILabel!
    @IBOutlet weak var CCLbl: UILabel!
    @IBOutlet weak var CityLbl: UILabel!
    @IBOutlet weak var TimeLbl: UILabel!
    @IBOutlet weak var ImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
