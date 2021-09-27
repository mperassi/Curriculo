//
//  BemVindosViewcontroller.swift
//  Curriculo
//
//  Created by Gabriele Namie on 27/09/21.
//

import Foundation
import UIKit

class BemvindosViewController: UIViewController {
    @IBOutlet weak var fraseSemCurriculo: UILabel!
    @IBOutlet weak var botaoAdd: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fraseSemCurriculo.numberOfLines = 0
        fraseSemCurriculo.textAlignment = .center
        
    }
}
