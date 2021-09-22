//
//  ViewController.swift
//  Curriculo
//
//  Created by Marcelo Perassi on 20/09/21.
//

import UIKit
import NotificationCenter

class FirstPageViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addLink: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    // Create Date
    let date = Date()

    // Create Date Formatter
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(FirstPageViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
           
           NotificationCenter.default.addObserver(self, selector: #selector(FirstPageViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        addLink.addTarget(self, action: #selector(dicionario1Pagina), for: .touchDown)


        
        // Do any additional setup after loading the view.
    }

    @IBAction func dicionario1Pagina(){
        tableView.dequeueReusableCell(withIdentifier: "textoCell")
        let indexPath = NSIndexPath(row: 0, section: 0)
        let multiCell = tableView.cellForRow(at: indexPath as IndexPath) as? TextoTableViewCell
        self.dictionary["Nome"] = multiCell?.nomeField.text
        
        let indexPathData = NSIndexPath(row: 1, section: 0)
        let multiCell1 = tableView.cellForRow(at: indexPathData as IndexPath) as? DataTableViewCell
        dateFormatter.dateFormat = "dd/MM/YY"
        self.dictionary["Data"] = multiCell1?.dataPicker.date.description

        
        let indexPathTel = NSIndexPath(row: 2, section: 0)
        let multiCell2 = tableView.cellForRow(at: indexPathTel as IndexPath) as? TextoTableViewCell
        self.dictionary["Tel"] = multiCell2?.nomeField.text
        
        let indexPathLocal = NSIndexPath(row: 3, section: 0)
        let multiCell3 = tableView.cellForRow(at: indexPathLocal as IndexPath) as? TextoTableViewCell
        self.dictionary["Local"] = multiCell3?.nomeField.text
        
        let indexPathEmail = NSIndexPath(row: 4, section: 0)
        let multiCell4 = tableView.cellForRow(at: indexPathEmail as IndexPath) as? TextoTableViewCell
        self.dictionary["Email"] = multiCell4?.nomeField.text
        
        let indexPathLink = NSIndexPath(row: 5, section: 0)
        let multiCell5 = tableView.cellForRow(at: indexPathLink as IndexPath) as? TextoTableViewCell
        self.dictionary["Link"] = multiCell5?.nomeField.text
        
        print(dictionary)

    }
    
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
    
extension FirstPageViewController: UITableViewDelegate{
    
}

extension FirstPageViewController: UITableViewDataSource{

    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "textoCell", for: indexPath) as! TextoTableViewCell
            cell.nomeLabel.text = "Nome"
            cell.nomeField.keyboardType = .default
            cell.nomeField.placeholder = "Digite seu nome completo"
            cell.nomeObs.text = "*Obrigatório"
//            print(dictValue)  // Printing the value
            return cell
            
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as! DataTableViewCell
            cell.dataPicker.tintColor = UIColor.init(named: "Ciano")
            cell.dataPicker.contentHorizontalAlignment = .left
            
            
            return cell
            
        } else if indexPath.row == 2 {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "textoCell", for: indexPath) as! TextoTableViewCell
            cell.nomeLabel.text = "Telefone"
            cell.nomeField.placeholder = "Exemplo: (00) 00000-0000"
            cell.nomeField.keyboardType = .numberPad
            cell.nomeObs.text = "*Obrigatório"
            return cell
            
        } else if indexPath.row == 3 {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "textoCell", for: indexPath) as! TextoTableViewCell
            cell.nomeLabel.text = "Localidade"
            cell.nomeField.keyboardType = .default
            cell.nomeField.placeholder = "Exemplo: São Paulo - SP"
            cell.nomeObs.text = "*Obrigatório"
            return cell
            
        } else if indexPath.row == 4 {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "textoCell", for: indexPath) as! TextoTableViewCell
            cell.nomeLabel.text = "E-mail"
            cell.nomeField.keyboardType = .emailAddress
            cell.nomeField.placeholder = "Exemplo: email@exemplo.com"
            cell.nomeObs.text = "*Obrigatório"
            return cell
            
        } else {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "textoCell", for: indexPath) as! TextoTableViewCell
            cell.nomeLabel.text = "Links adicionais"
            cell.nomeField.placeholder = "Exemplo: LinkedIN, Behance, Github"
            cell.nomeField.keyboardType = .URL
            cell.nomeObs.text = " "
            return cell
            
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    
}


