//
//  DescTableViewCell.swift
//  Curriculo
//
//  Created by Carolina Ortega on 24/09/21.
//

import UIKit

class DescricaoTableViewCell: UITableViewCell {
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var descObsLabel: UILabel!
    @IBOutlet var descTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        descTextView.delegate = self
        //MARK: Acessibilidade
        descLabel.isAccessibilityElement = true
        descLabel.accessibilityLabel = "Descrição"
        
        descObsLabel.isAccessibilityElement = true
        descObsLabel.accessibilityLabel = "Este item é de preenchimento obrigatório"
        
        descTextView.isAccessibilityElement = true
        descTextView.accessibilityLabel = "Descreva brevemente sua realização profissional"
        
        
        
//        self.accessibilityElements = [descLabel!, descTextView!]
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension DescricaoTableViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 200 // Change limit based on your requirement.
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descTextView?.textColor == UIColor(named: "Placeholder") {
            descTextView?.text = nil
            descTextView?.textColor = UIColor(named: "TextView")
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if ((descTextView?.text == "")) {
                descTextView?.text = "Descreva brevemente sua realização profissional.\nExemplo: Nota máxima na tese de conclusão de curso."
                descTextView?.textColor = UIColor(named: "Placeholder")
        }
    }
}

