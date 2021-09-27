//
//  TextTableViewCell.swift
//  Curriculo
//
//  Created by Carolina Ortega on 20/09/21.
//

import UIKit

class TextoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var nomeField: UITextField!
    @IBOutlet weak var nomeObs: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        


        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
