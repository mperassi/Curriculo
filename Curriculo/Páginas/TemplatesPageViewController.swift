//
//  TemplatesViewController.swift
//  Curriculo
//
//  Created by Carolina Ortega on 27/09/21.
//

import UIKit
import PDFKit

class TemplatesPageViewController: UIViewController {
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var botaoAnterior: UIBarButtonItem!
    @IBOutlet var botaoConcluir: UIBarButtonItem!
    @IBOutlet var primeiroModelo: UIButton!
    @IBOutlet var segundoModelo: UIButton!
    
//    @IBSegueAction func mudaPagina(_ coder: NSCoder) -> ProntoPageViewController? {

//        return ProntoPageViewController(coder: coder)
//    }
//    
    //Dicionário
    let defaults = UserDefaults.standard
    var dictionary: [String : Any] = [:]  //Dictionary which you want to save
    //    let dictValue = UserDefaults.standard.value(forKey: "DictValue") //Retrieving the value from user default
    
    @IBOutlet var cancelarBotao: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navegação
        self.navigationItem.setHidesBackButton(true, animated: false)
        botaoAnterior.style = .plain
        botaoAnterior.target = self
        botaoAnterior.action = #selector(changeViewController)
        
        cancelarBotao.action = #selector(cancelarAcao)
        cancelarBotao.target = self
        cancelarBotao.style = .plain
        cancelarBotao.action = #selector(cancelarAcao)
        
        
//        botaoConcluir.action = #selector(acaoConcluir)
//        botaoConcluir.target = self
//        botaoConcluir.style = .plain
        
        primeiroModelo.addTarget(self, action: #selector(acaoModelo1), for: .touchUpInside)
        segundoModelo.addTarget(self, action: #selector(acaoModelo2), for: .touchUpInside)
        
        //Dicionário
        if let userDataDictionary = defaults.dictionary(forKey: "DictValue"){
            dictionary = userDataDictionary
        }
        
        
    }
    
    //Navegação
    @objc func changeViewController(){
        
        let viewcontrollers = self.navigationController?.viewControllers
        
        viewcontrollers?.forEach({ (vc) in
            if  let inventoryListVC = vc as? QuintaPageViewController {
                self.navigationController!.popToViewController(inventoryListVC, animated: true)
            }
        })
    }
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
    

    @objc func acaoModelo1(){
        if !primeiroModelo.isSelected{
            primeiroModelo.setImage(UIImage(named: "modelo1Selected.png"), for: .normal)
            segundoModelo.setImage(UIImage(named: "modelo2.png"), for: .normal)
            segundoModelo.isSelected = false
            self.dictionary["Modelo"] = "Modelo 1 escolhido"
            defaults.setValue(dictionary, forKey: "DictValue") //Saved the Dictionary in user default (colocar na troca de pag)
            print(dictionary)
            
            
        } else{
            primeiroModelo.setImage(UIImage(named: "modelo1.png"), for: .normal)
            
        }
        primeiroModelo.isSelected = !primeiroModelo.isSelected
        
    }
    
    @objc func acaoModelo2(){
        if !segundoModelo.isSelected{
            segundoModelo.setImage(UIImage(named: "modelo2Selected.png"), for: .normal)
            primeiroModelo.setImage(UIImage(named: "modelo1.png"), for: .normal)
            primeiroModelo.isSelected = false
            self.dictionary["Modelo"] = "Modelo 2 escolhido"
            defaults.setValue(dictionary, forKey: "DictValue") //Saved the Dictionary in user default (colocar na troca de pag)

            print(dictionary)
        } else{
            segundoModelo.setImage(UIImage(named: "modelo2.png"), for: .normal)
            
        }
        segundoModelo.isSelected = !segundoModelo.isSelected
        
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "previewSegue" {
            guard let vc = segue.destination as? ProntoPageViewController else { return }
            
            if let nome = dictionary["Nome"]! as! String?,
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
            {
                
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
                vc.documentData = pdfCreator.criarCurriculo()
            }
        }
    }
}
extension TemplatesPageViewController: UINavigationControllerDelegate {
  // Not used, but necessary for compilation
}


