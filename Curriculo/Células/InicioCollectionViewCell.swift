//
//  InicioCollectionViewCell.swift
//  Curriculo
//
//  Created by Carolina Ortega on 30/09/21.
//

import UIKit

class InicioCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imagemCurriculo: UIImageView!
    @IBOutlet var apelido: UILabel!
    let cores : [UIImage?] = [UIImage(named: "InicioAzul"), UIImage(named: "InicioLaranja"), UIImage(named: "InicioVerde"), UIImage(named: "InicioPreto")]
    
    override func awakeFromNib() {
       super.awakeFromNib()
        imagemCurriculo.image = cores[Int.random(in: 0..<cores.count)]

       //custom logic goes here
    }
    
    
}




