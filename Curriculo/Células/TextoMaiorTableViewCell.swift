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
        
        self.isAccessibilityElement = false
        largeTextView?.delegate = self
        self.accessibilityElements = [largeTextLabel!, largeTextObs!, largeTextView!]
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        // Configure the view for the selected state
    }
    
    
    
}
extension TextoMaiorTableViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 300 // Change limit based on your requirement.
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if largeTextView?.textColor == UIColor.lightGray {
            largeTextView?.text = nil
            largeTextView?.textColor = UIColor(named: "TextView")
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if ((largeTextView?.text == "")) {
            if largeTextLabel.text == "Objetivo profissional"{
                largeTextView?.text = "carol"
                largeTextView?.textColor = UIColor.lightGray
            } else{
                largeTextView?.text = "gabi"
                largeTextView?.textColor = UIColor.lightGray
            }
            
        }
    }
}
