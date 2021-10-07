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
        inicioLabel.translatesAutoresizingMaskIntoConstraints = false
        fimLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dataInicio.topAnchor.constraint(equalTo: inicioLabel.bottomAnchor, constant: 10).isActive = true
        dataInicio.leadingAnchor.constraint(equalTo: inicioLabel.leadingAnchor, constant: 5).isActive = true
        dataInicio.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        dataFim.topAnchor.constraint(equalTo: dataInicio.topAnchor).isActive = true
        dataFim.leadingAnchor.constraint(equalTo: fimLabel.leadingAnchor, constant: 5).isActive = true
        dataFim.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        fimLabel.numberOfLines = 0
        
        //MARK: Acessibilidade - Botões de início, fim e picker
        self.isAccessibilityElement = false 
        
        
        duasDatasLabel.isAccessibilityElement = true
        duasDatasObs.isAccessibilityElement = true
        inicioLabel.isAccessibilityElement = true
        fimLabel.isAccessibilityElement = true
        
        inicioLabel.accessibilityLabel = "Início do período. Selecionar no picker"
        fimLabel.accessibilityLabel = " Fim do período. Selecionar no picker"
        
        
        accessibilityElements = [duasDatasLabel!, duasDatasObs!, inicioLabel!, dataInicio!, fimLabel!, dataFim!]
        
    
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
