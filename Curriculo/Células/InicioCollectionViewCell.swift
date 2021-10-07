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
    @IBOutlet var checkmarkLabel: UILabel!
    var iconeDeletar = UIImage(systemName: "checkmark.circle.fill")
    let cores : [UIImage?] = [UIImage(named: "InicioAzul"), UIImage(named: "InicioLaranja"), UIImage(named: "InicioVerde"), UIImage(named: "InicioPreto")]
    // 1
    var isInEditingMode: Bool = false {
        didSet {
            checkmarkLabel.isHidden = !isInEditingMode
        }
    }

    // 2
    override var isSelected: Bool {
        didSet {
            if isInEditingMode {
                checkmarkLabel.text = isSelected ? "✓" : ""
                checkmarkLabel.backgroundColor = isSelected ? UIColor(named: "Apagar") : .clear
                checkmarkLabel.layer.masksToBounds = true
                checkmarkLabel.layer.cornerRadius = isSelected ? 15 : 15
                checkmarkLabel.layer.borderColor = isSelected ? UIColor.white.cgColor : UIColor.clear.cgColor
                checkmarkLabel.layer.borderWidth = isSelected ? 1.5 : 0
                
            }
        }
    }
    
    override func awakeFromNib() {
       super.awakeFromNib()
        imagemCurriculo.image = cores[Int.random(in: 0..<cores.count)]

//        imagemCurriculo.isAccessibilityElement = true
//        apelido.isAccessibilityElement = true
//
//        imagemCurriculo.accessibilityLabel = ""
//        apelido.accessibilityLabel = "Modelos de currículo"
//
//        accessibilityElements = [apelido!, imagemCurriculo!]
    }
    
    func cor(_ cor:String) {
        imagemCurriculo.image = UIImage(named: "Inicio\(cor)") ?? imagemCurriculo.image
    }
    
    
}





