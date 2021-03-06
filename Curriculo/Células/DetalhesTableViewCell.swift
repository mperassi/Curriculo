//
//  NovaTableViewCell.swift
//  Curriculo
//
//  Created by Carolina Ortega on 24/09/21.
//

import UIKit

class DetalhesTableViewCell: UITableViewCell {
    @IBOutlet var novaLabel: UILabel!
    @IBOutlet weak var detalhesObs: UILabel!
    @IBOutlet var novaTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        //MARK: Acessibilidade
        novaLabel.isAccessibilityElement = true
        novaLabel.accessibilityLabel = "Detalhes"
        
        detalhesObs.isAccessibilityElement = true
        detalhesObs.accessibilityLabel = "Este item é de preenchimento obrigatório"
        
        
        novaTextView.delegate = self
        novaTextView.isAccessibilityElement = true
        novaTextView.accessibilityLabel = "Digite aqui detalhes da sua experiência profissional"
        
        accessibilityElements = [novaLabel!, detalhesObs!, novaTextView!]
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension DetalhesTableViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 200 // Change limit based on your requirement.
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.novaTextView?.textColor == UIColor(named: "Placeholder") {
            self.novaTextView?.text = nil
            self.novaTextView?.textColor = UIColor(named: "TextView")
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if ((novaTextView?.text == "")) {
            if novaLabel.text == "Detalhes"{
                novaTextView?.text = "Digite aqui detalhes da sua experiência profissional"
                novaTextView?.textColor = UIColor(named: "Placeholder")
            }
            
        }
    }
}


