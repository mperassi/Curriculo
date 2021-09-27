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
        
        
        //MARK: Acessibilidade
        nomeLabel.isAccessibilityElement = true
        nomeLabel.accessibilityLabel = "Nome"
        
        nomeField.isAccessibilityElement = true
        nomeField.accessibilityLabel = "Nome"
        nomeField.accessibilityTraits = .staticText
        nomeField.accessibilityHint = "Digite seu nome completo"
        
        nomeObs.isAccessibilityElement = true
        nomeObs.accessibilityLabel = "Obrigatório"
        nomeObs.accessibilityTraits = .staticText
        nomeObs.accessibilityHint = "Este item é de preenchimento obrigatório"
        
        
        self.accessibilityElements = [nomeLabel, nomeField, nomeObs]

        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
