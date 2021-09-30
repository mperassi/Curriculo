//
//  ProntoPageViewController.swift
//  Curriculo
//
//  Created by Carolina Ortega on 29/09/21.
//

import UIKit
import PDFKit

class ProntoPageViewController: UIViewController {
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var botaoCompartilhar: UIBarButtonItem!
    @IBOutlet var pdfView: PDFView!
    @IBOutlet var cancelarBotao: UIBarButtonItem!
    
    public var documentData: Data?
    
    //Dicionário
    let defaults = UserDefaults.standard
    var dictionary: [String : Any] = [:]  //Dictionary which you want to save
    //    let dictValue = UserDefaults.standard.value(forKey: "DictValue") //Retrieving the value from user default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navegação
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        cancelarBotao.action = #selector(cancelarAcao)
        cancelarBotao.target = self
        cancelarBotao.style = .plain
        
        botaoCompartilhar.action = #selector(acaoCompartilhar)
        botaoCompartilhar.target = self
        botaoCompartilhar.style = .plain
        
        //Dicionário
        if let userDataDictionary = defaults.dictionary(forKey: "DictValue"){
            dictionary = userDataDictionary
            
        }
        if let data = documentData {
              pdfView.document = PDFDocument(data: data)
              pdfView.autoScales = true
            }
        
    }
    //Navegação
    @objc func backViewController(){
        let viewcontrollers = self.navigationController?.viewControllers
        
        viewcontrollers?.forEach({ (vc) in
            if  let inventoryListVC = vc as? BemvindosViewController {
                self.navigationController!.popToViewController(inventoryListVC, animated: true)
            }
        })
    }
    @objc func cancelarAcao(){
        
        let ac = UIAlertController(title: "Tem certeza?", message: "Cancelando você perderá todas as informações inseridas", preferredStyle: .alert)
        ac.view.tintColor = UIColor(named: "Ciano")
        ac.addAction(UIAlertAction(title: "Sim", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            self.backViewController()
        }))
        ac.addAction(UIAlertAction(title: "Não", style: UIAlertAction.Style.cancel, handler: {(action:UIAlertAction!) in
            
            
        }))
        present(ac,animated: true)
    }
        @objc func acaoCompartilhar() {
            //1
            guard
                let nome = dictionary["Nome"]! as! String?,
                let nascimento = dictionary["Data"]! as! String?,
                let tel = dictionary["Tel"]! as! String?,
                let local = dictionary["Local"]! as! String?,
                let email = dictionary["Email"]! as! String?,
                let link = dictionary["Link"]! as! String?,
                let objetivoProf = dictionary["Objetivo"]! as! String?,
                let resumoProf = dictionary["Resumo"]! as! String?,
                let nomeEmp = dictionary["NomeEmpresa"]! as! String?,
                let cargoEmp = dictionary["NomeCargo"]! as! String?,
                let dataIniEmp = dictionary["EmpregoDataIni"]! as! String?,
                let dataFimEmp = dictionary["EmpregoDataFim"]! as! String?,
                let detalhesEmp = dictionary["Detalhes"]! as! String?,
                let nomeInst = dictionary["NomeInst"]! as! String?,
                let cursoInst = dictionary["NomeCurso"]! as! String?,
                let dataIniInst = dictionary["InstDataIni"]! as! String?,
                let dataFimInst = dictionary["InstDataFim"]! as! String?,
                let realizacao = dictionary["NomeConq"]! as! String?,
                let descReal = dictionary["DescConq"]! as! String?,
                let dataIniReal = dictionary["ConqDataIni"]! as! String?,
                let dataFimReal = dictionary["ConqDataFim"]! as! String?,
                let deficiencia = dictionary["NomeDef"]! as! String?,
                let deficienciaObs = dictionary["ObsDef"]! as! String?,
                let modelo = dictionary["Modelo"]! as! String?
    
            else {
                // 2
                let alert = UIAlertController(title: "All Information Not Provided", message: "You must supply all information to create a flyer.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            // 3
            let pdfCreator = PDFCreator(nome: nome,
                                        nascimento: nascimento,
                                        tel: tel,
                                        local: local,
                                        email: email,
                                        link: link,
                                        objetivoProf: objetivoProf,
                                        resumoProf: resumoProf,
                                        nomeEmp: nomeEmp,
                                        cargoEmp: cargoEmp,
                                        dataIniEmp: dataIniEmp,
                                        dataFimEmp: dataFimEmp,
                                        detalhesEmp: detalhesEmp,
                                        nomeInst: nomeInst,
                                        cursoInst: cursoInst,
                                        dataIniInst: dataIniInst,
                                        dataFimInst: dataFimInst,
                                        realizacao: realizacao,
                                        descReal: descReal,
                                        dataIniReal: dataIniReal,
                                        dataFimReal: dataFimReal,
                                        deficiencia: deficiencia,
                                        deficienciaObs: deficienciaObs,
                                        modelo: modelo)
            let pdfData = pdfCreator.criarCurriculo()
            let vc = UIActivityViewController(activityItems: [pdfData], applicationActivities: [])
            present(vc, animated: true, completion: nil)
        }
    
}
