//
//  DateTableViewCell.swift
//  Curriculo
//
//  Created by Carolina Ortega on 20/09/21.
//

import UIKit

class DataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var dataObs: UILabel!
    @IBOutlet weak var dataPicker: UIDatePicker!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UIDatePicker.appearance().tintColor = UIColor(named: "Ciano")
        
        //MARK: Acessibilidade
        dataLabel.isAccessibilityElement = true
        dataLabel.accessibilityLabel = "Data de nascimento"
        
        dataObs.isAccessibilityElement = true
        dataObs.accessibilityLabel = "Este item é de preenchimento brigatório"
        
        dataPicker.isAccessibilityElement = true
        dataPicker.accessibilityLabel = "Selecione a data de nascimento"
        
        self.accessibilityElements = [dataLabel, dataObs, dataPicker]
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
