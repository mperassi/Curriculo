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
        obsTextView.delegate = self
        
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
extension ObsTableViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 200 // Change limit based on your requirement.
    }
}
