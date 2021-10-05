//
//  ProntoPageViewController.swift
//  Curriculo
//
//  Created by Carolina Ortega on 29/09/21.
//

import UIKit
import PDFKit

class ProntoPageViewController: UIViewController {
    @IBOutlet var fraseConcluido: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var botaoCompartilhar: UIBarButtonItem!
    @IBOutlet var pdfView: PDFView!
    @IBOutlet var cancelarBotao: UIBarButtonItem!
    
    public var documentData: Data?
    
    //Dicionário
    let defaults = UserDefaults.standard
    var dictionary: [String : String] = [:]  //Dictionary which you want to save
    //    let dictValue = UserDefaults.standard.value(forKey: "DictValue") //Retrieving the value from user default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pdfView.backgroundColor = .clear
        //Navegação
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        cancelarBotao.action = #selector(backViewController)
        cancelarBotao.target = self
        cancelarBotao.style = .plain
        
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
        
        if let dictionary = defaults.value(forKey: "DictValue") as? [String: String] {
            defaults.removeObject(forKey: "DictValue")
            CurriculoRepositorio.shared.salvar(nome: dictionary["NomeCurriculo"] ?? "erro", dados: dictionary)
        } else {
            print("NAO SALVOU")
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
        //1
        guard
            let nome = dictionary["Nome"],
            let nascimento = dictionary["Data"],
            let tel = dictionary["Tel"],
            let local = dictionary["Local"],
            let email = dictionary["Email"],
            let link = dictionary["Link"],
            let objetivoProf = dictionary["Objetivo"],
            let resumoProf = dictionary["Resumo"],
            let nomeEmp = dictionary["NomeEmpresa"],
            let cargoEmp = dictionary["NomeCargo"],
            let dataIniEmp = dictionary["EmpregoDataIni"],
            let dataFimEmp = dictionary["EmpregoDataFim"],
            let detalhesEmp = dictionary["Detalhes"],
            let nomeInst = dictionary["NomeInst"],
            let cursoInst = dictionary["NomeCurso"],
            let dataIniInst = dictionary["InstDataIni"],
            let dataFimInst = dictionary["InstDataFim"],
            let realizacao = dictionary["NomeConq"],
            let descReal = dictionary["DescConq"],
            let dataIniReal = dictionary["ConqDataIni"],
            let dataFimReal = dictionary["ConqDataFim"],
            let deficiencia = dictionary["NomeDef"],
            let deficienciaObs = dictionary["ObsDef"],
            let modelo = dictionary["Modelo"],
            let cor = dictionary["Cor"]
                
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
                                    modelo: modelo,
                                    cor: cor)
        let pdfData = pdfCreator.criarCurriculo()
        let vc = UIActivityViewController(activityItems: [pdfData], applicationActivities: [])
        present(vc, animated: true, completion: nil)
    }
    
}
