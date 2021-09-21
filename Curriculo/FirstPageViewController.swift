//
//  ViewController.swift
//  Curriculo
//
//  Created by Marcelo Perassi on 20/09/21.
//

import UIKit

class FirstPageViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
//        self.pickerCidade.dataSource = self
//        self.pickerCidade.delegate = self
        // Do any additional setup after loading the view.
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
            cell.nomeObs.text = "*Obrigatório"
            return cell
        }; if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as! DataTableViewCell
            return cell
        }; if indexPath.row == 2 {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "textoCell", for: indexPath) as! TextoTableViewCell
            cell.nomeLabel.text = "Telefone"
            cell.nomeField.keyboardType = .numberPad
            cell.nomeObs.text = "*Obrigatório"

            return cell
            
        }; if indexPath.row == 3 {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "textoCell", for: indexPath) as! TextoTableViewCell
            cell.nomeLabel.text = "Localidade"
            cell.nomeField.keyboardType = .default
            cell.nomeObs.text = "*Obrigatório"
            return cell
            
        }; if indexPath.row == 4 {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "textoCell", for: indexPath) as! TextoTableViewCell
            cell.nomeLabel.text = "E-mail"
            cell.nomeField.keyboardType = .emailAddress
            cell.nomeObs.text = "*Obrigatório"
            return cell
            
        } else {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "textoCell", for: indexPath) as! TextoTableViewCell
            cell.nomeLabel.text = "Links adicionais"
            cell.nomeField.keyboardType = .URL
            cell.nomeObs.text = " "
            return cell
            
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    
}
//extension ViewController: UIPickerViewDataSource{
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 2
//    }
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return 5
//    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return "cucu"
//    }
//}
//extension ViewController: UIPickerViewDelegate{
//    
//}


