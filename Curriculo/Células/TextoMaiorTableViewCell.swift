//
//  LargeTextTableViewCell.swift
//  Curriculo
//
//  Created by Carolina Ortega on 22/09/21.
//

import UIKit

class TextoMaiorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var largeTextLabel: UILabel!
    @IBOutlet weak var largeTextView: UITextView?
    @IBOutlet var largeTextObs: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        largeTextView?.layer.cornerRadius = 10
        
        largeTextLabel.isAccessibilityElement = true

        largeTextView?.isAccessibilityElement = true
        
        
        //MARK: Acessibilidade
        
        largeTextLabel.isAccessibilityElement = true
        largeTextLabel.accessibilityLabel = "Objetivo profissional"
        
        largeTextView?.isAccessibilityElement = true
        largeTextView?.accessibilityLabel = "Digite seu objetivo profissional"
        
        largeTextObs.isAccessibilityElement = true
        largeTextObs.accessibilityLabel = "Item de preenchimento obrigatório"
      
        
        self.accessibilityElements = [largeTextLabel, largeTextView, largeTextObs]

        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        // Configure the view for the selected state
    }
    
}
