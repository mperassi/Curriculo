//
//  BemVindosViewcontroller.swift
//  Curriculo
//
//  Created by Gabriele Namie on 27/09/21.
//

import Foundation
import UIKit

class BemvindosViewController: UIViewController {
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var fraseSemCurriculo: UILabel!
    @IBOutlet weak var botaoAdd: UIBarButtonItem!
    @IBOutlet weak var imagemBoasVindas: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)

        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        fraseSemCurriculo.numberOfLines = 0
        fraseSemCurriculo.textAlignment = .center
        
        
        fraseSemCurriculo.isAccessibilityElement = true
        fraseSemCurriculo.accessibilityLabel = "Clique no botão Adicionar no canto superior direito para criar seu primeiro currículo."
        
        botaoAdd.isAccessibilityElement = true
        botaoAdd.accessibilityLabel = "Adicionar novo currículo"
        
        imagemBoasVindas.isAccessibilityElement = true
        imagemBoasVindas.accessibilityLabel = "Foto centralizada de uma mulher negra, cadeirante, vestindo um conjunto de moletom de cor azul, com um tênis vermelho. A mulher está com a mão direita na roda da cadeira e a mão direita acenando. Imediatamente atrás da mulher, há duas formas geométricas arredondadas de cor azul e amarela."
    
        accessibilityElements = [imagemBoasVindas!,fraseSemCurriculo!, botaoAdd!]
        
        if UIAccessibility.isVoiceOverRunning {
            fraseSemCurriculo.text = ""
            
            
        
            
        }
    }
}
