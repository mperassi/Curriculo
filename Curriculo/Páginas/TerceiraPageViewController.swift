//
//  ThirdPageViewController.swift
//  Curriculo
//
//  Created by Carolina Ortega on 22/09/21.
//

import UIKit
import NotificationCenter

class TerceiraPageViewController: UIViewController {
    @IBOutlet weak var cancelarBotao: UIBarButtonItem!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var botaoAnterior: UIBarButtonItem!
    @IBOutlet weak var addExp: UIButton!
    @IBSegueAction func mudaTerceiraPagina(_ coder: NSCoder) -> QuartaPageViewController? {
        dicionario3Pagina()
        return QuartaPageViewController(coder: coder)
    }
    
    //Dicionário
    
    let defaults = UserDefaults.standard
    var dictionary: [String : Any] = [:]  //Dictionary which you want to save
    //    let dictValue = UserDefaults.standard.value(forKey: "DictValue") //Retrieving the value from user default
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        //Navegação
        self.navigationItem.setHidesBackButton(true, animated: false)
        botaoAnterior.style = .plain
        botaoAnterior.target = self
        botaoAnterior.action = #selector(changeViewController)
        addExp.layer.cornerRadius = 10
        
        cancelarBotao.action = #selector(cancelarAcao)
        cancelarBotao.target = self
        cancelarBotao.style = .plain
        
        //Dicionário
        if let userDataDictionary = defaults.dictionary(forKey: "DictValue"){
            dictionary = userDataDictionary
        }
        
        //Scroll
        NotificationCenter.default.addObserver(self, selector: #selector(PrimeiraPageViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(PrimeiraPageViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    //Dicionário
    @IBAction func dicionario3Pagina() {
        tableView.dequeueReusableCell(withIdentifier: "textoCell")
        let indexPath = NSIndexPath(row: 0, section: 0)
        let multiCell = tableView.cellForRow(at: indexPath as IndexPath) as? TextoTableViewCell
        self.dictionary["NomeEmpresa"] = multiCell?.nomeField.text
        
        tableView.dequeueReusableCell(withIdentifier: "textoCell")
        let indexPathCargo = NSIndexPath(row: 1, section: 0)
        let multiCell1 = tableView.cellForRow(at: indexPathCargo as IndexPath) as? TextoTableViewCell
        self.dictionary["NomeCargo"] = multiCell1?.nomeField.text
        
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
        self.dictionary["EmpregoDataIni"] = dataini
        self.dictionary["EmpregoDataFim"] = datafim
        
        tableView.dequeueReusableCell(withIdentifier: "novaTextCell")
        let indexPath3 = NSIndexPath(row: 3, section: 0)
        let multiCell3 = tableView.cellForRow(at: indexPath3 as IndexPath) as? NovaTableViewCell
        self.dictionary["Detalhes"] = multiCell3?.novaTextView?.text
        
        defaults.setValue(dictionary, forKey: "DictValue") //Saved the Dictionary in user default (colocar na troca de pag)
        print(dictionary)
        
        if (multiCell?.nomeField.text == "") || (multiCell1?.nomeField.text == "") || (multiCell3?.novaTextView?.text == "") {
            print("vazio")
            let ac = UIAlertController(title: "Dados faltando", message: "Um dos campos não foi preenchido...", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            ac.view.tintColor = UIColor(named: "Ciano")
            present(ac, animated: true)
        } else{
            print("cheio")
        }
        
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
        
        let ac = UIAlertController(title: "Progresso", message: "Parece que você não fez a sua reflexão diária.. 😥\n Que tal dar uma passada por lá?", preferredStyle: .alert)
        ac.view.tintColor = UIColor(named: "Ciano")
        ac.addAction(UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            self.backViewController()
        }))
        ac.addAction(UIAlertAction(title: "Agora não", style: UIAlertAction.Style.cancel, handler: {(action:UIAlertAction!) in
            
            
        }))
        present(ac,animated: true)
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
    //Navegação
    @objc func changeViewController(){
        
        let viewcontrollers = self.navigationController?.viewControllers
        
        viewcontrollers?.forEach({ (vc) in
            if  let inventoryListVC = vc as? SegundaPageViewController {
                self.navigationController!.popToViewController(inventoryListVC, animated: true)
            }
        })
        
    }
    
}
//TableView
extension TerceiraPageViewController: UITableViewDelegate{
    
}

extension TerceiraPageViewController: UITableViewDataSource{
    
    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "textoCell", for: indexPath) as! TextoTableViewCell
            cell.nomeLabel.text = "Nome da Empresa"
            cell.nomeField.keyboardType = .default
            cell.nomeField.placeholder = "Digite o nome da empresa"
            cell.nomeObs.text = "*Obrigatório"
            //            print(dictValue)  // Printing the value
            
            //MARK: Acessibilidade - Nome da Empresa
            cell.nomeLabel.isAccessibilityElement = true
            cell.nomeLabel.accessibilityLabel = "Nome da Empresa"
            
            cell.nomeField.isAccessibilityElement = true
            cell.nomeField.accessibilityLabel = "Digite o nome da empresa"
            
            cell.nomeObs.isAccessibilityElement = true
            cell.nomeObs.accessibilityLabel = "Este item é de preenchimento obrigatório"
           
            self.tableView.accessibilityElements = [cell.nomeLabel, cell.nomeObs, cell.nomeField]

            
            if UIAccessibility.isVoiceOverRunning {
                cell.nomeField.placeholder = ""
            }
            
            return cell
            
        } else if indexPath.row == 1 {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "textoCell", for: indexPath) as! TextoTableViewCell
            cell.nomeLabel.text = "Cargo"
            cell.nomeField.keyboardType = .default
            cell.nomeField.placeholder = "Digite o cargo na empresa"
            cell.nomeObs.text = "*Obrigatório"
            //            print(dictValue)  // Printing the value
            
            //MARK: Acessibilidade - Cargo na empresa
            cell.nomeLabel.isAccessibilityElement = true
            cell.nomeLabel.accessibilityLabel = "Cargo"
            
            cell.nomeField.isAccessibilityElement = true
            cell.nomeField.accessibilityLabel = "Digite o cargo na empresa"
            
            cell.nomeObs.isAccessibilityElement = true
            cell.nomeObs.accessibilityLabel = "Este item é de preenchimento obrigatório"
            
            self.accessibilityElements = [cell.nomeLabel, cell.nomeField, cell.nomeObs]

            
            if UIAccessibility.isVoiceOverRunning {
                cell.nomeField.placeholder = ""
            }
            
            return cell
            
        } else if indexPath.row == 2 {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "duasDatasCell", for: indexPath) as! DuasDatasTableViewCell
            //            cell.duasDatasLabel.text = "Período"
            //            cell.duasDatasObs.text = "*Obrigatório"
            //            print(dictValue)  // Printing the value
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "novaTextCell", for: indexPath) as! NovaTableViewCell
            cell.selectionStyle = .none
            return cell
            //            guard let safeCell = cell else {return UITableViewCell()}
            //            return safeCell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
            return 300
            
        } else if indexPath.row == 2{
            return 140
        }
        else {
            return 105
        }
    }
    
    
}



