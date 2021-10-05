//
//  ProntoPageViewController2.swift
//  Curriculo
//
//  Created by Carolina Ortega on 29/09/21.
//

import UIKit
import PDFKit

class ProntoPageViewController2: UIViewController {
    @IBOutlet var fraseConcluido: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var botaoCompartilhar: UIBarButtonItem!
    @IBOutlet var pdfView: PDFView!
    
    public var documentData: Data?
    
    //Dicionário
    let defaults = UserDefaults.standard
    var dictionary: [String : String] = [:]  //Dictionary which you want to save
    //    let dictValue = UserDefaults.standard.value(forKey: "DictValue") //Retrieving the value from user default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pdfView.backgroundColor = .clear
        //Navegação
//        self.navigationItem.setHidesBackButton(true, animated: false)
        
        botaoCompartilhar.action = #selector(acaoCompartilhar)
        botaoCompartilhar.target = self
        botaoCompartilhar.style = .plain
        
        //Dicionário
        if let userDataDictionary = defaults.dictionary(forKey: "DictValue") as? [String: String] {
            dictionary = userDataDictionary
            
        }
        if let data = documentData {
            pdfView.document = PDFDocument(data: data)
            pdfView.autoScales = true
        }
        
        
    }
    
    //Navegação
    @objc
    func backViewController(){
        let viewcontrollers = self.navigationController?.viewControllers
        
        viewcontrollers?.forEach({ (vc) in
            if  let inventoryListVC = vc as? BemvindosViewController {
                self.navigationController!.popToViewController(inventoryListVC, animated: true)
            }
        })
    }

    @objc
    func acaoCompartilhar() {
        
        if let data = self.documentData {
            let vc = UIActivityViewController(activityItems: [data], applicationActivities: [])
            present(vc, animated: true, completion: nil)
        }
    }
    
}
