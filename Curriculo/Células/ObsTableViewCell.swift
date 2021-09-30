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
        
        
        //MARK: Acessibilidade
       obsLabel.isAccessibilityElement = true
       obsLabel.accessibilityLabel = "Observações"
        
        obsLabelObs.isAccessibilityElement = true
        obsLabelObs.accessibilityLabel = "Este campo é de preenchimento obrigatório"
        
        obsTextView.isAccessibilityElement = true
        obsTextView.accessibilityLabel = "Fale brevemente sobre a sua deficiência e das possíveis adaptações necessárias ao ambiente de trabalho."
        

        self.accessibilityElements = [obsLabel!, obsLabelObs!, obsTextView!]

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
