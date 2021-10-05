//
//  FifthPageViewController.swift
//  Curriculo
//
//  Created by Carolina Ortega on 23/09/21.
//

import UIKit
import NotificationCenter

class QuintaPageViewController: UIViewController {
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var primeiraTableView: UITableView!
    @IBOutlet var botaoAnterior: UIBarButtonItem!
    @IBOutlet weak var cancelarBotao: UIBarButtonItem!
    @IBOutlet var segundaTableView: UITableView!
    @IBOutlet var `switch`: UISwitch!
    
    @IBSegueAction func mudaPagina(_ coder: NSCoder) -> TemplatesPageViewController? {
        dicionario5Pagina()
        return TemplatesPageViewController(coder: coder)
    }
    
    //Dicionário
    let defaults = UserDefaults.standard
    var dictionary: [String : String] = [:]  //Dictionary which you want to save
    //    let dictValue = UserDefaults.standard.value(forKey: "DictValue") //Retrieving the value from user default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Scroll
        NotificationCenter.default.addObserver(self, selector: #selector(PrimeiraPageViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(PrimeiraPageViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //Switch
        self.switch.isOn = false
        segundaTableView.isHidden = true
        self.switch.addTarget(self, action: #selector(stateChanged(switchState:)), for: .valueChanged)

        cancelarBotao.action = #selector(cancelarAcao)
        cancelarBotao.target = self
        cancelarBotao.style = .plain
        
        //TableView
        self.primeiraTableView.register(UITableViewCell.self, forCellReuseIdentifier: "primeiraTabela")
        self.primeiraTableView.dataSource = self
        self.primeiraTableView.delegate = self
        
        self.segundaTableView.register(UITableViewCell.self, forCellReuseIdentifier: "segundaTabela")
        self.segundaTableView.dataSource = self
        self.segundaTableView.delegate = self
        
        //Navegação
        self.navigationItem.setHidesBackButton(true, animated: false)
        botaoAnterior.style = .plain
        botaoAnterior.target = self
        botaoAnterior.action = #selector(changeViewController)
//        addConq.layer.cornerRadius = 10

        
        //Dicionário
        if let userDataDictionary = defaults.dictionary(forKey: "DictValue") as? [String: String] {
            dictionary = userDataDictionary
        }
    }
    
    //Switch
    @objc func stateChanged(switchState: UISwitch) {
       if switchState.isOn {
           segundaTableView.isHidden = false
       } else {
           segundaTableView.isHidden = true
       }
   }
    
    //Dicionário
    @IBAction func dicionario5Pagina() {
        primeiraTableView.dequeueReusableCell(withIdentifier: "textoCell")
        let indexPath = NSIndexPath(row: 0, section: 0)
        let multiCell = primeiraTableView.cellForRow(at: indexPath as IndexPath) as? TextoTableViewCell
        self.dictionary["NomeConq"] = multiCell?.nomeField.text
        
        primeiraTableView.dequeueReusableCell(withIdentifier: "descCell")
        let indexPath1 = NSIndexPath(row: 1, section: 0)
        let multiCell1 = primeiraTableView.cellForRow(at: indexPath1 as IndexPath) as? DescricaoTableViewCell
        self.dictionary["DescConq"] = multiCell1?.descTextView?.text
        
        let indexPathDatas = NSIndexPath(row: 2, section: 0)
        let multiCell2 = primeiraTableView.cellForRow(at: indexPathDatas as IndexPath) as? DuasDatasTableViewCell
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
        self.dictionary["ConqDataIni"] = dataini
        self.dictionary["ConqDataFim"] = datafim
        
        segundaTableView.dequeueReusableCell(withIdentifier: "textoCell")
        let indexPathDef = NSIndexPath(row: 0, section: 0)
        let multiCellDef = segundaTableView.cellForRow(at: indexPathDef as IndexPath) as? TextoTableViewCell
        self.dictionary["NomeDef"] = multiCellDef?.nomeField.text
        
        segundaTableView.dequeueReusableCell(withIdentifier: "obsCell")
        let indexPathObs = NSIndexPath(row: 1, section: 0)
        let multiCellObs = segundaTableView.cellForRow(at: indexPathObs as IndexPath) as? ObservacaoTableViewCell
        self.dictionary["ObsDef"] = multiCellObs?.obsTextView.text
        
        //Ações próxima página
        self.dictionary["Modelo"] = ""
        self.dictionary["Cor"] = ""
        self.dictionary["NomeCurriculo"] = ""
        
        defaults.setValue(dictionary, forKey: "DictValue") //Saved the Dictionary in user default (colocar na troca de pag)
        print(dictionary)
        
      
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
        ac.view.tintColor = UIColor(named: "Ciano2")
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
            if  let inventoryListVC = vc as? QuartaPageViewController {
                self.navigationController!.popToViewController(inventoryListVC, animated: true)
            }
        })
    }
}

//TableView
extension QuintaPageViewController: UITableViewDelegate{
    
}

extension QuintaPageViewController: UITableViewDataSource{
    
    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableview == primeiraTableView {
            return 3
        } else {
            return 2
        }
    }
    
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableview == primeiraTableView {
            if indexPath.row == 0 {
                let cell  = primeiraTableView.dequeueReusableCell(withIdentifier: "textoCell", for: indexPath) as! TextoTableViewCell
                cell.nomeLabel.text = "Título"
                cell.nomeField.keyboardType = .default
                cell.nomeField.placeholder = "Digite uma realização"
                cell.nomeObs.text = " "
                
                //MARK: Acessibilidade - Realização
                cell.nomeLabel.isAccessibilityElement = true
                cell.nomeLabel.accessibilityLabel = "Título"
                
                cell.nomeField.isAccessibilityElement = true
                cell.nomeField.accessibilityLabel = "Digite uma realização profissional"
                
                cell.accessibilityElements = [cell.nomeLabel!, cell.nomeField!]

                
                if UIAccessibility.isVoiceOverRunning {
                    cell.nomeField.placeholder = ""
                }
                
                return cell
                
            } else if indexPath.row == 1{
                let cell = primeiraTableView.dequeueReusableCell(withIdentifier: "descCell", for: indexPath) as? DescricaoTableViewCell
                cell?.selectionStyle = .none
                cell?.descObsLabel.text = " "
                
                guard let safeCell = cell else {return UITableViewCell()}
                return safeCell
                
            }
            else {
                let cell = primeiraTableView.dequeueReusableCell(withIdentifier: "duasDatasCell", for: indexPath) as! DuasDatasTableViewCell
                cell.duasDatasObs.text = " "
                return cell
            }
        } else {
            if indexPath.row == 0 {
                let cell  = segundaTableView.dequeueReusableCell(withIdentifier: "textoCell", for: indexPath) as! TextoTableViewCell
                cell.nomeLabel.text = "Deficiência"
                cell.nomeField.keyboardType = .default
                cell.nomeField.placeholder = "Digite o tipo de deficiência"
                cell.nomeObs.text = "*Obrigatório"
                
                //MARK: Acessibilidade - Deficiência
                cell.nomeLabel.isAccessibilityElement = true
                cell.nomeLabel.accessibilityLabel = "Deficiência"
                
                cell.nomeField.isAccessibilityElement = true
                cell.nomeField.accessibilityLabel = "Digite o seu tipo de deficiência"
                
                cell.nomeObs.isAccessibilityElement = true
                cell.nomeObs.accessibilityLabel = "Este item é de preenchimento obrigatório"
                
                cell.accessibilityElements = [`switch`!, cell.nomeLabel!, cell.nomeObs!, cell.nomeField!]
                
                if UIAccessibility.isVoiceOverRunning {
                    cell.nomeField.placeholder = ""
                }
                
                return cell
                
            } else {
                let cell  = segundaTableView.dequeueReusableCell(withIdentifier: "obsCell", for: indexPath) as! ObservacaoTableViewCell
                cell.obsLabelObs.text = " "
                cell.selectionStyle = .none
                
                //MARK: Acessibilidade - TextView do campo de observações
                cell.obsLabel.isAccessibilityElement = true
                cell.obsLabel.accessibilityLabel = "Observações"
                
                cell.obsLabelObs.isAccessibilityElement = true
                cell.obsLabelObs.accessibilityLabel = "Este campo é de preenchimento obrigatório"
                
                cell.obsTextView.isAccessibilityElement = true
                cell.obsTextView.accessibilityLabel = "Fale brevemente sobre a sua deficiência e das possíveis adaptações necessárias ao ambiente de trabalho."
                
                cell.accessibilityElements = [cell.obsLabel!, cell.obsTextView!]
                
                return cell
            }
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == primeiraTableView {
            if indexPath.row == 1 {
                return 160
            } else if indexPath.row == 2{
                return 140
            }
            else {
                return 105
            }
        } else {
            if indexPath.row == 1{
                return 180
            } else {
                return 105
            }
        }
      
    }

}
