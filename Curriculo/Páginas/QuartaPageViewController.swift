//
//  FourthPageViewController.swift
//  Curriculo
//
//  Created by Carolina Ortega on 23/09/21.
//

import UIKit
import NotificationCenter

class QuartaPageViewController: UIViewController {
    @IBOutlet weak var cancelarBotao: UIBarButtonItem!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var botaoAnterior: UIBarButtonItem!
    @IBSegueAction func mudaQuartaPagina(_ coder: NSCoder) -> QuintaPageViewController? {
        dicionario4Pagina()
        return QuintaPageViewController(coder: coder)
        
    }

     
    
    //Dicionário
    
    let defaults = UserDefaults.standard
    var dictionary: [String : String] = [:]  //Dictionary which you want to save
    //    let dictValue = UserDefaults.standard.value(forKey: "DictValue") //Retrieving the value from user default
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        botaoAnterior.style = .plain
        botaoAnterior.target = self
        botaoAnterior.action = #selector(changeViewController)
//        addForm.layer.cornerRadius = 10
//
//         //MARK: Acessibilidade
//         addForm.isAccessibilityElement = true
//         addForm.accessibilityLabel = "Adicionar nova formação acadêmica"
        cancelarBotao.action = #selector(cancelarAcao)
        cancelarBotao.target = self
        cancelarBotao.style = .plain
  
        //Dicionário
        if let userDataDictionary = defaults.dictionary(forKey: "DictValue") as? [String: String] {
            dictionary = userDataDictionary
        }
        //Scroll
        NotificationCenter.default.addObserver(self, selector: #selector(PrimeiraPageViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(PrimeiraPageViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

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
    //Navegação
    @objc func changeViewController(){
        
        let viewcontrollers = self.navigationController?.viewControllers
        
        viewcontrollers?.forEach({ (vc) in
            if  let inventoryListVC = vc as? TerceiraPageViewController {
                self.navigationController!.popToViewController(inventoryListVC, animated: true)
            }
        })
        
    }
    
    @IBAction func dicionario4Pagina() {
        tableView.dequeueReusableCell(withIdentifier: "textoCell")
        let indexPath = NSIndexPath(row: 0, section: 0)
        let multiCell = tableView.cellForRow(at: indexPath as IndexPath) as? TextoTableViewCell
        self.dictionary["NomeInst"] = multiCell?.nomeField.text
        
        tableView.dequeueReusableCell(withIdentifier: "textoCell")
        let indexPathCargo = NSIndexPath(row: 1, section: 0)
        let multiCell1 = tableView.cellForRow(at: indexPathCargo as IndexPath) as? TextoTableViewCell
        self.dictionary["NomeCurso"] = multiCell1?.nomeField.text
        
        tableView.dequeueReusableCell(withIdentifier: "duasDatasCell")
        let indexPathDatas = NSIndexPath(row: 2, section: 0)
        let multiCell2 = tableView.cellForRow(at: indexPathDatas as IndexPath) as? DuasDatasTableViewCell
        // Create Date
        let date = multiCell2?.dataInicio.date
        let date2 = multiCell2?.dataFim.date
        
        // Create Date Formatter
        let dateFormatter = DateFormatter()
        
        // Set Date Format
        dateFormatter.dateFormat = "dd/MM/YY"
        
        // Convert Date to String
        let dataini = dateFormatter.string(from: date!)
        let datafim = dateFormatter.string(from: date2!)
        self.dictionary["InstDataIni"] = dataini
        self.dictionary["InstDataFim"] = datafim
        
        defaults.setValue(dictionary, forKey: "DictValue") //Saved the Dictionary in user default (colocar na troca de pag)
        print(dictionary)
        
        if (multiCell?.nomeField.text == "") || (multiCell1?.nomeField.text == ""){
            print("vazio")
            let ac = UIAlertController(title: "Dados incompletos", message: "Um dos campos obrigatórios não foi preenchido", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            ac.view.tintColor = UIColor(named: "Ciano")
            present(ac, animated: true)
        } else{
            print("cheio")
        }
    }
    //Scroll
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        
        // reset back the content inset to zero after keyboard is gone
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
    }


}

//TableView
extension QuartaPageViewController: UITableViewDelegate{
    
}

extension QuartaPageViewController: UITableViewDataSource{
    
    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "textoCell", for: indexPath) as! TextoTableViewCell
            cell.nomeLabel.text = "Nome da Instituição"
            cell.nomeField.keyboardType = .default
            cell.nomeField.placeholder = "Digite a instituição de ensino"
            cell.nomeObs.text = "*Obrigatório"
            
            //MARK: Acessibilidade - Instituição
            cell.nomeLabel.isAccessibilityElement = true
            cell.nomeLabel.accessibilityLabel = "Nome da Instituição"
            
            cell.nomeField.isAccessibilityElement = true
            cell.nomeField.accessibilityLabel = "Digite o nome da sua instituição de ensino"
            
            cell.nomeObs.isAccessibilityElement = true
            cell.nomeObs.accessibilityLabel = "Este item é de preenchimento obrigatório"
            
            cell.accessibilityElements = [cell.nomeLabel!, cell.nomeObs!, cell.nomeField!]

            
            if UIAccessibility.isVoiceOverRunning {
                cell.nomeField.placeholder = ""
            }
            
            return cell
            
        } else if indexPath.row == 1 {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "textoCell", for: indexPath) as! TextoTableViewCell
            cell.nomeLabel.text = "Curso"
            cell.nomeField.keyboardType = .default
            cell.nomeField.placeholder = "Digite o curso ou grau de ensino"
            cell.nomeObs.text = "*Obrigatório"
            
            //MARK: Acessibilidade - Curso
            cell.nomeLabel.isAccessibilityElement = true
            cell.nomeLabel.accessibilityLabel = "Curso"
            
            cell.nomeField.isAccessibilityElement = true
            cell.nomeField.accessibilityLabel = "Digite o curso ou grau de ensino"
            
            cell.nomeObs.isAccessibilityElement = true
            cell.nomeObs.accessibilityLabel = "Este item é de preenchimento obrigatório"
            
            cell.accessibilityElements = [cell.nomeLabel!, cell.nomeObs!, cell.nomeField!]

            
            if UIAccessibility.isVoiceOverRunning {
                cell.nomeField.placeholder = ""
            }
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "duasDatasCell", for: indexPath) as! DuasDatasTableViewCell
            
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return 140
        }
        else {
            return 105
        }
    }
    
    
}

