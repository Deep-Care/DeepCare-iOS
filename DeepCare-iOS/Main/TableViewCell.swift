//
//  TableViewCell.swift
//  DeepCare-iOS
//
//  Created by Param Bole on 2/1/20.
//  Copyright © 2020 sjkim. All rights reserved.
//

import UIKit

protocol TalkerTableViewCellDelegate: AnyObject {
    func talkerInformation(_ tableViewCell: TableViewCell, button: String, talker: Person)
}

class TableViewCell: UITableViewCell {

    @IBOutlet weak var talkerImageView: UIImageView!
    @IBOutlet weak var talkerNameLabel: UILabel!

    weak var delegate: TalkerTableViewCellDelegate?
    var talker: Person?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configuration(_ person: Person) {
        talkerNameLabel.text = person.name
        talkerImageView.image = UIImage(named: person.image)
        talker = person
    }

    @IBAction func videoCallButtonAction(_ sender: Any) {
        if let delegates = delegate, let person = talker {
            delegates.talkerInformation(self, button: "Video", talker: person)
        }
    }
    
    @IBAction func phoneCallButtonAction(_ sender: Any) {
        if let delegates = delegate, let person = talker {
            delegates.talkerInformation(self, button: "Phone", talker: person)
        }
    }
}
