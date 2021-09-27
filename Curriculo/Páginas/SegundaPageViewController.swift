//
//  SecondPageViewController.swift
//  Curriculo
//
//  Created by Carolina Ortega on 22/09/21.
//

import UIKit
import NotificationCenter

class SegundaPageViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var botaoAnterior: UIBarButtonItem!
    @IBSegueAction func mudaSegundaPagina(_ coder: NSCoder) -> TerceiraPageViewController? {
        dicionario2Pagina()
        return TerceiraPageViewController(coder: coder)
    }
    
    //Dicionário
    let defaults = UserDefaults.standard
    var dictionary: [String : Any] = [:]  //Dictionary which you want to save
//    let dictValue = UserDefaults.standard.value(forKey: "DictValue") //Retrieving the value from user default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //Navegação
        botaoAnterior.style = .plain
        botaoAnterior.target = self
        botaoAnterior.action = #selector(changeViewController)
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        //Dicionário
        if let userDataDictionary = defaults.dictionary(forKey: "DictValue"){
            dictionary = userDataDictionary
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(SegundaPageViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SegundaPageViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        
    }

    @objc func changeViewController(){
            let viewcontrollers = self.navigationController?.viewControllers
            
            viewcontrollers?.forEach({ (vc) in
                if  let inventoryListVC = vc as? PrimeiraPageViewController {
                    self.navigationController!.popToViewController(inventoryListVC, animated: true)
                }
            })
            
            }

    @objc func keyboardWillShow(notification: NSNotification) {
      guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
      else {
        // if keyboard size is not available for some reason, dont do anything
        return
      }

      let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)
      scrollView.contentInset = contentInsets
//      scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(notification: NSNotification) {
      let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)


      // reset back the content inset to zero after keyboard is gone
      scrollView.contentInset = contentInsets
      scrollView.scrollIndicatorInsets = contentInsets
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        let scrollPoint : CGPoint = CGPoint.init(x:0, y:textView.frame.origin.y)
        self.scrollView.setContentOffset(scrollPoint, animated: true)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        self.scrollView.setContentOffset(CGPoint.zero, animated: true)
    }
    
    //Dicionário
    
    @IBAction func dicionario2Pagina() {
        tableView.dequeueReusableCell(withIdentifier: "largeTextCell")
        let indexPath = NSIndexPath(row: 0, section: 0)
        let multiCell = tableView.cellForRow(at: indexPath as IndexPath) as? TextoMaiorTableViewCell
        self.dictionary["Objetivo"] = multiCell?.largeTextView?.text
        
        tableView.dequeueReusableCell(withIdentifier: "largeTextCell")
        let indexPath1 = NSIndexPath(row: 1, section: 0)
        let multiCell1 = tableView.cellForRow(at: indexPath1 as IndexPath) as? TextoMaiorTableViewCell
        self.dictionary["Resumo"] = multiCell1?.largeTextView?.text
        
        defaults.setValue(dictionary, forKey: "DictValue") //Saved the Dictionary in user default (colocar na troca de pag)
        print(dictionary)
        
    }
}
//TableView
extension SegundaPageViewController: UITableViewDelegate{
    
}

extension SegundaPageViewController: UITableViewDataSource{

    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "largeTextCell", for: indexPath) as! TextoMaiorTableViewCell
            cell.largeTextLabel.text = "Objetivo profissional"
            cell.selectionStyle = .none
            
            //MARK: Acessibilidade - Objetivo profissional
            cell.largeTextLabel.isAccessibilityElement = true
            cell.largeTextLabel.accessibilityLabel = "Objetivo profissional"
            

            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "largeTextCell", for: indexPath) as! TextoMaiorTableViewCell
            cell.largeTextLabel.text = "Resumo profissional"
            cell.selectionStyle = .none
            
            //MARK: Acessibilidade - Resumo profissional
            cell.largeTextLabel.isAccessibilityElement = true
            cell.largeTextLabel.accessibilityLabel = "Resumo profissinoal"
            
        
            
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
}
