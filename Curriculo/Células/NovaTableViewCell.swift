//
//  NovaTableViewCell.swift
//  Curriculo
//
//  Created by Carolina Ortega on 24/09/21.
//

import UIKit

class NovaTableViewCell: UITableViewCell {
    @IBOutlet var novaLabel: UILabel!
    @IBOutlet var novaTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        //MARK: Acessibilidade
       novaLabel.isAccessibilityElement = true
       novaLabel.accessibilityLabel = "Detalhes"

      novaTextView.isAccessibilityElement = true
      novaTextView.accessibilityLabel = "Digite aqui detalhes da sua experiência acadêmica ou profissional"
        
        self.accessibilityElements = [novaLabel, novaTextView!]

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


