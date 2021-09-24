//
//  ObsTableViewCell.swift
//  Curriculo
//
//  Created by Carolina Ortega on 24/09/21.
//

import UIKit

class ObsTableViewCell: UITableViewCell {
    @IBOutlet var obsLabel: UILabel!
    @IBOutlet var obsLabelObs: UILabel!
    @IBOutlet var obsTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
