//
//  ObsTableViewCell.swift
//  Curriculo
//
//  Created by Carolina Ortega on 24/09/21.
//

import UIKit

class ObservacaoTableViewCell: UITableViewCell {
    @IBOutlet var obsLabel: UILabel!
    @IBOutlet var obsLabelObs: UILabel!
    @IBOutlet var obsTextView: UITextView!
    
 override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        obsTextView.delegate = self
 
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension ObservacaoTableViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 200 // Change limit based on your requirement.
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if obsTextView?.textColor == UIColor(named: "Placeholder") {
            obsTextView?.text = nil
            obsTextView?.textColor = UIColor(named: "TextView")
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if ((obsTextView?.text == "")) {
                obsTextView?.text = "Descreva brevemente sua deficiência e as possíveis adaptações necessárias ao ambiente de trabalho. Se julgar necessário, informe seu CID neste campo."
                obsTextView?.textColor = UIColor(named: "Placeholder")
        }
    }
}
