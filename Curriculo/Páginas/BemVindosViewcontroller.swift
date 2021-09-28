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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)

        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        fraseSemCurriculo.numberOfLines = 0
        fraseSemCurriculo.textAlignment = .center
        
        fraseSemCurriculo.isAccessibilityElement = true
        fraseSemCurriculo.accessibilityLabel = "Clique no botão Adicionar no canto superior direito para criar seu primeiro currículo."
        
        self.accessibilityElements = [fraseSemCurriculo, botaoAdd]
        
        if UIAccessibility.isVoiceOverRunning {
            fraseSemCurriculo.text = ""
            
            
        
            
        }
    }
}
