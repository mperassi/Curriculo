//
//  FifthPageViewController.swift
//  Curriculo
//
//  Created by Carolina Ortega on 23/09/21.
//

import UIKit

class FifthPageViewController: UIViewController {
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var botaoAnterior: UIBarButtonItem!
    @IBOutlet var addConq: UIButton!
    
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
        addConq.layer.cornerRadius = 10
        addConq.addTarget(self, action: #selector(dicionario4Pagina), for: .touchDown)
        
        //Dicionário
        if let userDataDictionary = defaults.dictionary(forKey: "DictValue"){
            dictionary = userDataDictionary
        }
    }
    
    //Dicionário
    @IBAction func dicionario4Pagina() {
        tableView.dequeueReusableCell(withIdentifier: "textoCell")
        let indexPath = NSIndexPath(row: 0, section: 0)
        let multiCell = tableView.cellForRow(at: indexPath as IndexPath) as? TextoTableViewCell
        self.dictionary["NomeConq"] = multiCell?.nomeField.text
        
        tableView.dequeueReusableCell(withIdentifier: "largeTextCell")
        let indexPath3 = NSIndexPath(row: 1, section: 0)
        let multiCell3 = tableView.cellForRow(at: indexPath3 as IndexPath) as? LargeTextTableViewCell
        self.dictionary["DescConq"] = multiCell3?.largeTextView?.text
        
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
        self.dictionary["ConqDataIni"] = dataini
        self.dictionary["ConqDataFim"] = datafim
        
        defaults.setValue(dictionary, forKey: "DictValue") //Saved the Dictionary in user default (colocar na troca de pag)
        print(dictionary)
      
}
    //Navegação
    @objc func changeViewController(){
        
        let viewcontrollers = self.navigationController?.viewControllers
        
        viewcontrollers?.forEach({ (vc) in
            if  let inventoryListVC = vc as? FourthPageViewController {
                self.navigationController!.popToViewController(inventoryListVC, animated: true)
            }
        })
        

    }
}

//TableView
extension FifthPageViewController: UITableViewDelegate{
    
}

extension FifthPageViewController: UITableViewDataSource{
    
    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "textoCell", for: indexPath) as! TextoTableViewCell
            cell.nomeLabel.text = "Título"
            cell.nomeField.keyboardType = .default
            cell.nomeField.placeholder = "Digite o título da conquista?"
            cell.nomeObs.text = " "
            return cell
            
        } else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "largeTextCell", for: indexPath) as? LargeTextTableViewCell
            cell?.selectionStyle = .none
            
            guard let safeCell = cell else {return UITableViewCell()}
            return safeCell
            
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "duasDatasCell", for: indexPath) as! DuasDatasTableViewCell
   
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 160
        } else if indexPath.row == 2{
            return 140
        }
        else {
            return 105
        }
    }

}
