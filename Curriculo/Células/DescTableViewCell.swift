//
//  DescTableViewCell.swift
//  Curriculo
//
//  Created by Carolina Ortega on 24/09/21.
//

import UIKit

class DescTableViewCell: UITableViewCell {
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var descObsLabel: UILabel!
    @IBOutlet var descTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
