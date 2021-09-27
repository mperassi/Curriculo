//
//  DescTableViewCell.swift
//  Curriculo
//
//  Created by Carolina Ortega on 24/09/21.
//

import UIKit

class DescTableViewCell: UITableViewCell {
    @IBOutlet var descLabel: UILabel! //TextView de descrição da página de Conquistas (5a página)
    @IBOutlet var descObsLabel: UILabel! 
    @IBOutlet var descTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
        //MARK: Acessibilidade
        descLabel.isAccessibilityElement = true
        descLabel.accessibilityLabel = "Descrição"
        
        descObsLabel.isAccessibilityElement = true
        descObsLabel.accessibilityLabel = "Este item é de preenchimento obrigatório"
        
        descTextView.isAccessibilityElement = true
        descTextView.accessibilityLabel = "Fale brevemente sobre sua realização"
        
        

        self.accessibilityElements = [descLabel, descObsLabel, descTextView]

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
