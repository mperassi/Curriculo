//
//  TableViewCell.swift
//  Curriculo
//
//  Created by Carolina Ortega on 22/09/21.
//

import UIKit

class DuasDatasTableViewCell: UITableViewCell {
    @IBOutlet weak var duasDatasLabel: UILabel!
    @IBOutlet weak var duasDatasObs: UILabel!
    @IBOutlet weak var dataInicio: UIDatePicker!
    @IBOutlet weak var dataFim: UIDatePicker!
    @IBOutlet weak var inicioLabel: UILabel!
    @IBOutlet weak var fimLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dataInicio.translatesAutoresizingMaskIntoConstraints = false
        dataFim.translatesAutoresizingMaskIntoConstraints = false
        
        dataInicio.topAnchor.constraint(equalTo: inicioLabel.bottomAnchor, constant: 10).isActive = true
        dataInicio.leadingAnchor.constraint(equalTo: inicioLabel.leadingAnchor, constant: 5).isActive = true
        dataInicio.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        dataFim.topAnchor.constraint(equalTo: dataInicio.topAnchor).isActive = true
        dataFim.leadingAnchor.constraint(equalTo: fimLabel.leadingAnchor, constant: 5).isActive = true
        dataFim.widthAnchor.constraint(equalToConstant: 100).isActive = true

//func acessibilidade() {}
        //MARK: Acessibilidade
       duasDatasLabel.isAccessibilityElement = true
       duasDatasLabel.accessibilityLabel = "Período"
        
       duasDatasObs.isAccessibilityElement = true
       duasDatasObs.accessibilityLabel = "Item de preenchimento obrigatório"

        inicioLabel.isAccessibilityElement = true
        inicioLabel.accessibilityLabel = "Início do período"
        
        fimLabel.isAccessibilityElement = true
        fimLabel.accessibilityLabel = "Fim do período"
        
        dataInicio.isAccessibilityElement = true
        dataInicio.accessibilityLabel = "Selecione a data de início da realização"
        
        dataFim.isAccessibilityElement = true
        dataFim.accessibilityLabel = "Selecione a data do fim da realização"

        self.accessibilityElements = [duasDatasLabel, duasDatasObs, dataInicio, dataFim, inicioLabel, fimLabel]

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
