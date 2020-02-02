//
//  TableViewCell.swift
//  DeepCare-iOS
//
//  Created by Param Bole on 2/1/20.
//  Copyright © 2020 sjkim. All rights reserved.
//

import UIKit
import Kingfisher

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var talkerImageView: UIImageView!
    @IBOutlet weak var talkerNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configuration(_ person: Person) {
        let url = URL(string: person.image)
        talkerNameLabel.text = person.name
        talkerImageView.kf.setImage(with: url)
    }

}
