//
//  ViewController.swift
//  Curriculo
//
//  Created by Marcelo Perassi on 20/09/21.
//

import UIKit

class FirstPageViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addLink: UIButton!
    
    let dateFormatter = DateFormatter()
    
    let defaults = UserDefaults.standard
    var dictionary: [String : String] = [:]  //Dictionary which you want to save
//    let dictValue = UserDefaults.standard.value(forKey: "DictValue") //Retrieving the value from user default

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        addLink.layer.cornerRadius = 10
//        self.dictionary = defaults.value(forKey: "DictValue") as! [String : String] //colocar nas outras vc, no viewdidload
        defaults.setValue(dictionary, forKey: "DictValue") //Saved the Dictionary in user default (colocar na troca de pag)
        
        addLink.addTarget(self, action: #selector(acaoLink), for: .touchDown)

        // Do any additional setup after loading the view.
    }

    @IBAction func acaoLink(){
        print(dictionary)
//        self.dictionary["Nome"] =
//        self.dictionary["DataNasc"] =
//        self.dictionary["Tel"] =
//        self.dictionary["Local"] =
//        self.dictionary["Email"] =
//        self.dictionary["Link"] = 

        
    }
    
}
    
extension FirstPageViewController: UITableViewDelegate{
    
}

extension FirstPageViewController: UITableViewDataSource{

    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "textoCell", for: indexPath) as! TextoTableViewCell
            let tipo = "Nome"
            cell.nomeLabel.text = tipo
            cell.nomeField.keyboardType = .default
            cell.nomeField.placeholder = "Digite seu nome completo"
            cell.nomeObs.text = "*Obrigatório"
            self.dictionary[tipo] = cell.nomeField.text
//            print(dictValue)  // Printing the value
            return cell
            
        } else if indexPath.row == 1 {
            let tipo = "DataNasc"
            let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as! DataTableViewCell
            dateFormatter.dateFormat = "dd/MM/YY"
            self.dictionary[tipo] = dateFormatter.string(from: cell.dataPicker.date)
            return cell
            
        } else if indexPath.row == 2 {
            let tipo = "Tel"
            let cell  = tableView.dequeueReusableCell(withIdentifier: "textoCell", for: indexPath) as! TextoTableViewCell
            cell.nomeLabel.text = "Telefone"
            cell.nomeField.placeholder = "Exemplo: (00) 00000-0000"
            cell.nomeField.keyboardType = .numberPad
            cell.nomeObs.text = "*Obrigatório"
            self.dictionary[tipo] = cell.nomeField.text
            return cell
            
        } else if indexPath.row == 3 {
            let tipo = "Local"
            let cell  = tableView.dequeueReusableCell(withIdentifier: "textoCell", for: indexPath) as! TextoTableViewCell
            cell.nomeLabel.text = "Localidade"
            cell.nomeField.keyboardType = .default
            cell.nomeField.placeholder = "Exemplo: São Paulo - SP"
            cell.nomeObs.text = "*Obrigatório"
            self.dictionary[tipo] = cell.nomeField.text
            return cell
            
        } else if indexPath.row == 4 {
            let tipo = "Email"
            let cell  = tableView.dequeueReusableCell(withIdentifier: "textoCell", for: indexPath) as! TextoTableViewCell
            cell.nomeLabel.text = "E-mail"
            cell.nomeField.keyboardType = .emailAddress
            cell.nomeField.placeholder = "Exemplo: email@exemplo.com"
            cell.nomeObs.text = "*Obrigatório"
            self.dictionary[tipo] = cell.nomeField.text
            return cell
            
        } else {
            let tipo = "Link"
            let cell  = tableView.dequeueReusableCell(withIdentifier: "textoCell", for: indexPath) as! TextoTableViewCell
            cell.nomeLabel.text = "Links adicionais"
            cell.nomeField.placeholder = "Exemplo: LinkedIN, Behance, Github"
            cell.nomeField.keyboardType = .URL
            cell.nomeObs.text = " "
            self.dictionary[tipo] = cell.nomeField.text
            return cell
            
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    
}


