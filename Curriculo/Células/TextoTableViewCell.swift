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
    }
//    func setTag(tag: Int){
//        inputTxt.tag = 100+tag
//    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }

    
}
//class YourCustomCell: UITableViewCell {
//    //MARK: Private Properties
//    @IBOutlet fileprivate weak var inputTxt: UITextField!
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//}
//extension YourCustomCell: UITextFieldDelegate{
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        nextTextField?(textField.tag)
//        return textField.resignFirstResponder()
//    }
//}
