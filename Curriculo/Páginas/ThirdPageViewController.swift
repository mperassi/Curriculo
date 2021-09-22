//
//  ThirdPageViewController.swift
//  Curriculo
//
//  Created by Carolina Ortega on 22/09/21.
//

import UIKit

class ThirdPageViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var botaoAnterior: UIBarButtonItem!
    
    //    let defaults = UserDefaults.standard
    //    var dictionary: [String : String] = [:]  //Dictionary which you want to save
    //    let dictValue = UserDefaults.standard.value(forKey: "DictValue") //Retrieving the value from user default
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        //            addLink.layer.cornerRadius = 10
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        botaoAnterior.style = .plain
        botaoAnterior.target = self
        botaoAnterior.action = #selector(changeViewController)
        
        
        
        //            defaults.setValue(dictionary, forKey: "DictValue") //Saved the Dictionary in user default (colocar na troca de pag)
        //
        //            NotificationCenter.default.addObserver(self, selector: #selector(FirstPageViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        //
        //               NotificationCenter.default.addObserver(self, selector: #selector(FirstPageViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        //
        //            addLink.addTarget(self, action: #selector(dicionario1Pagina), for: .touchDown)
        
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
    
    @objc func changeViewController(){
            
            let viewcontrollers = self.navigationController?.viewControllers
            
            viewcontrollers?.forEach({ (vc) in
                if  let inventoryListVC = vc as? SecondPageViewController {
                    self.navigationController!.popToViewController(inventoryListVC, animated: true)
                }
            })
            
            }
    
}
extension ThirdPageViewController: UITableViewDelegate{
    
}

extension ThirdPageViewController: UITableViewDataSource{
    
    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "textoCell", for: indexPath) as! TextoTableViewCell
            cell.nomeLabel.text = "Nome da Empresa"
            cell.nomeField.keyboardType = .default
            cell.nomeField.placeholder = "Digite o nome da empresa"
            cell.nomeObs.text = "*Obrigatório"
            //            print(dictValue)  // Printing the value
            return cell
            
        } else if indexPath.row == 1 {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "textoCell", for: indexPath) as! TextoTableViewCell
            cell.nomeLabel.text = "Cargo"
            cell.nomeField.keyboardType = .default
            cell.nomeField.placeholder = "Digite o cargo na empresa"
            cell.nomeObs.text = "*Obrigatório"
            //            print(dictValue)  // Printing the value
            return cell
            
        } else {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "textoCell", for: indexPath) as! TextoTableViewCell
            cell.nomeLabel.text = "Detalhes"
            cell.nomeField.keyboardType = .default
            cell.nomeField.placeholder = "Digite o cargo na empresa"
            cell.nomeObs.text = "*Obrigatório"
            //            print(dictValue)  // Printing the value
            return cell
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 105

        } else if indexPath.row == 1{
            return 105

        }
        else {
            return 300
        }
    }
    
    
}



