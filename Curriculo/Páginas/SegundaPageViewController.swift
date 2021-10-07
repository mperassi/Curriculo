//
//  SecondPageViewController.swift
//  Curriculo
//
//  Created by Carolina Ortega on 22/09/21.
//

import UIKit
import NotificationCenter

class SegundaPageViewController: UIViewController {
    @IBOutlet weak var cancelarBotao: UIBarButtonItem!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var botaoAnterior: UIBarButtonItem!
    @IBSegueAction func mudaSegundaPagina(_ coder: NSCoder) -> TerceiraPageViewController? {
        dicionario2Pagina()
        return TerceiraPageViewController(coder: coder)
    }
    
    //Dicionário
    let defaults = UserDefaults.standard
    var dictionary: [String : String] = [:]  //Dictionary which you want to save
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
        
        //Botão cancelar
        cancelarBotao.action = #selector(cancelarAcao)
        cancelarBotao.target = self
        cancelarBotao.style = .plain
        //Dicionário
        if let userDataDictionary = defaults.dictionary(forKey: "DictValue") as? [String:String] {
            dictionary = userDataDictionary
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(SegundaPageViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SegundaPageViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    
    
    deinit{
        NotificationCenter.default.removeObserver(self)
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
    
    @objc func changeViewController(){
        let viewcontrollers = self.navigationController?.viewControllers
        
        viewcontrollers?.forEach({ (vc) in
            if  let inventoryListVC = vc as? PrimeiraPageViewController {
                self.navigationController!.popToViewController(inventoryListVC, animated: true)
            }
        })
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    //    func textViewDidBeginEditing(_ textView: UITextView) {
    //        let scrollPoint : CGPoint = CGPoint.init(x:0, y:textView.frame.origin.y)
    //        self.scrollView.setContentOffset(scrollPoint, animated: true)
    //    }
    //
    //    func textViewDidEndEditing(_ textView: UITextView) {
    //        self.scrollView.setContentOffset(CGPoint.zero, animated: true)
    //    }
    
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
        
        if (multiCell?.largeTextView?.text == "") || (multiCell1?.largeTextView?.text == ""){
            print("vazio")
            let ac = UIAlertController(title: "Dados incompletos", message: "Um dos campos obrigatórios não foi preenchido", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            ac.view.tintColor = UIColor(named: "Ciano")
            present(ac, animated: true)
        } else{
            print("cheio")
        }
        
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
            if cell.largeTextLabel.text == "Objetivo profissional" {
                cell.largeTextLabel.isAccessibilityElement = true
                cell.largeTextLabel.accessibilityLabel = "Objetivo Profissional"
                cell.largeTextView?.text = "carol"
                cell.largeTextView?.textColor = UIColor.lightGray
                
                cell.largeTextView?.isAccessibilityElement = true
                cell.largeTextView?.accessibilityLabel = "Digite aqui seu objetivo profissional"
       
            }


            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "largeTextCell", for: indexPath) as! TextoMaiorTableViewCell
            cell.largeTextLabel.text = "Resumo profissional"
            cell.selectionStyle = .none
            
            //MARK: Acessibilidade - Resumo profissional
            if cell.largeTextLabel.text == "Resumo profissional" {
                cell.largeTextLabel.isAccessibilityElement = true
                cell.largeTextLabel.accessibilityLabel = "Resumo Profissional"
                cell.largeTextView?.text = "gabi"
                cell.largeTextView?.textColor = UIColor.lightGray
                
                cell.largeTextView?.isAccessibilityElement = true
                cell.largeTextView?.accessibilityLabel = "Digite aqui seu resumo profissional"
                
              
            }
            return cell

        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
}
