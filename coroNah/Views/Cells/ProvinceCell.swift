//
//  ProvinsiCell.swift
//  InfoCorona
//
//  Created by Sendo Tjiam on 12/09/21.
//

import UIKit

class ProvinceCell: UITableViewCell {

    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var provinceName: UILabel!
    @IBOutlet weak var positiveCase: UILabel!
    @IBOutlet weak var recoveredCase: UILabel!
    @IBOutlet weak var deathCase: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        containerView.cardShadow(offSet: CGSize(width: 1.0, height: 2.0), radius: 2.5)
        containerView.makeRoundedCorner(radius: 6)
    }
    
    func setProvinceData() {
        
    }
}
