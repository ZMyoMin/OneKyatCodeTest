//
//  HomeCollectionViewCell.swift
//  OneK
//
//  Created by BCMM on 25/01/2022.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var imgAds: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupCardView()

    }
    
    func setupCardView(){
        cardView.backgroundColor = .white

        cardView.layer.cornerRadius = 0.0

        cardView.layer.shadowColor = UIColor.systemGray.cgColor

        cardView.layer.shadowOffset = CGSize(width: 0.5, height: 12.0)

        cardView.layer.shadowRadius = 6.0

        cardView.layer.shadowOpacity = 0.7
    }

}
