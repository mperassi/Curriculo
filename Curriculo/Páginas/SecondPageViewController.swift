//
//  SecondPageViewController.swift
//  Curriculo
//
//  Created by Carolina Ortega on 22/09/21.
//

import UIKit
import NotificationCenter

class SecondPageViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var botaoAnterior: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        botaoAnterior.style = .plain
        botaoAnterior.target = self
        botaoAnterior.action = #selector(changeViewController)
        
        self.navigationItem.setHidesBackButton(true, animated: false)

        // Do any additional setup after loading the view.
    }

    @objc func changeViewController(){
            
            let viewcontrollers = self.navigationController?.viewControllers
            
            viewcontrollers?.forEach({ (vc) in
                if  let inventoryListVC = vc as? FirstPageViewController {
                    self.navigationController!.popToViewController(inventoryListVC, animated: true)
                }
            })
            
            }
}
extension SecondPageViewController: UITableViewDelegate{
    
}

extension SecondPageViewController: UITableViewDataSource{

    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "largeTextCell", for: indexPath) as! LargeTextTableViewCell
            cell.largeTextLabel.text = "Objetivo profissional"
            cell.largeTextView.layer.cornerRadius = 10
            cell.largeTextView.layer.borderColor = .init(red: 46, green: 112, blue: 160, alpha: 1)
            cell.selectionStyle = .none

            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "largeTextCell", for: indexPath) as! LargeTextTableViewCell
            cell.largeTextLabel.text = "Resumo profissional"
            cell.largeTextView.layer.cornerRadius = 10
            cell.selectionStyle = .none
            
            return cell
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
}
