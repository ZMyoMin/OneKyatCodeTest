//
//  DetailTableViewCell.swift
//  OneK
//
//  Created by BCMM on 27/01/2022.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePhoto: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        profilePhoto.layer.cornerRadius = 25
        profilePhoto.layer.borderWidth = 0.2
        profilePhoto.layer.borderColor = UIColor.gray.cgColor
    }
    
}
