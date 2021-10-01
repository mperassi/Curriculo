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
        novaTextView.delegate = self
        novaTextView.isAccessibilityElement = true
        novaTextView.accessibilityLabel = "Digite aqui detalhes da sua experiência profissional"
        
        self.accessibilityElements = [novaLabel!, novaTextView!]
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension NovaTableViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 200 // Change limit based on your requirement.
    }
}


