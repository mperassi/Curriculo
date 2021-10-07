//
//  TemplatesViewController.swift
//  Curriculo
//
//  Created by Carolina Ortega on 27/09/21.
//



import UIKit
import PDFKit

class TemplatesPageViewController: UIViewController {
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var botaoAnterior: UIBarButtonItem!
    @IBOutlet var botaoConcluir: UIBarButtonItem!
    @IBOutlet var primeiroModelo: UIButton!
    @IBOutlet var segundoModelo: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var corLaranja: UIButton!
    @IBOutlet var corAzul: UIButton!
    @IBOutlet var corVerde: UIButton!
    @IBOutlet var corPreto: UIButton!
    @IBOutlet weak var modelosTitulo: UILabel!
    @IBOutlet weak var labelObs: UILabel!
    @IBOutlet weak var coresLabel: UILabel!
    @IBOutlet weak var passos: UILabel!
    @IBOutlet weak var coresLabelObs: UILabel!
    
    
    //Dicionário
    let defaults = UserDefaults.standard
    var dictionary: [String : String] = [:]  //Dictionary which you want to save
    //    let dictValue = UserDefaults.standard.value(forKey: "DictValue") //Retrieving the value from user default
    
    @IBOutlet var cancelarBotao: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Tableview
        tableView.delegate = self
        tableView.dataSource = self
        
        //Navegação
        self.navigationItem.setHidesBackButton(true, animated: false)
        botaoAnterior.style = .plain
        botaoAnterior.target = self
        botaoAnterior.action = #selector(changeViewController)
        
        cancelarBotao.action = #selector(cancelarAcao)
        cancelarBotao.target = self
        cancelarBotao.style = .plain
        cancelarBotao.action = #selector(cancelarAcao)
        
        
        primeiroModelo.addTarget(self, action: #selector(acaoModelo1), for: .touchDown)
        segundoModelo.addTarget(self, action: #selector(acaoModelo2), for: .touchDown)
        
        
        corLaranja.addTarget(self, action: #selector(acaoLaranja), for: .touchDown)
        corAzul.addTarget(self, action: #selector(acaoAzul), for: .touchDown)
        corVerde.addTarget(self, action: #selector(acaoVerde), for: .touchDown)
        corPreto.addTarget(self, action: #selector(acaoPreto), for: .touchDown)
        
        
        //Dicionário
        if let userDataDictionary = defaults.dictionary(forKey: "DictValue") as? [String:String] {
            dictionary = userDataDictionary
        }

        //MARK: Acessibilidade - Descrição dos modelos de currículo
        primeiroModelo.isAccessibilityElement = true
        segundoModelo.isAccessibilityElement = true
        
        
        primeiroModelo.accessibilityLabel = "Este currículo é um modelo simples no qual o seu nome está centralizado. As informações encontram-se à esquerda. Os subtítulos estão em destaque com letras maiores, e em negrito. Logo abaixo de cada subtítulo estão as informações inseridas previamente nos campos do formulário."
        
        segundoModelo.accessibilityLabel = "Este currículo é um modelo personalizado no qual possui semi formas geométricas pequenas no canto superior direito da página, no canto inferior direito, e na esquerda levemente abaixo do centro. Seu nome está centralizado como título da página. As informações encontram-se à esquerda. Os subtítulos estão em destaque com letras maiores, e em negrito. Logo abaixo de cada subtítulo estão as informações inseridas previamente nos campos do formulário."
        
            //MARK: Acessibilidade - Descrição dos botões de cores, obrigatório e Modelo
        corLaranja.isAccessibilityElement = true
        corAzul.isAccessibilityElement = true
        corVerde.isAccessibilityElement = true
        corPreto.isAccessibilityElement = true
        labelObs.isAccessibilityElement = true
        modelosTitulo.isAccessibilityElement = true
        botaoAnterior.isAccessibilityElement = true
        botaoConcluir.isAccessibilityElement = true
        
        corLaranja.accessibilityLabel = "Botão de selecionar cor do currículo. Cor: laranja"
        corAzul.accessibilityLabel = "Botão de selecionar cor do currículo. Cor: azul escuro"
        corVerde.accessibilityLabel = "Botão de selecionar cor do currículo. Cor: verde esmeralda"
        corPreto.accessibilityLabel = "Botão de selecionar cor do currículo. Cor: preto"
        
        labelObs.accessibilityLabel = "Este item é de preenchimento obrigatório"
        modelosTitulo.accessibilityLabel = "Modelos de currículo"
        
        botaoAnterior.accessibilityLabel = "Anterior"
        botaoConcluir.accessibilityLabel = "Concluir"
            
            

        //MARK: Iniciar a leitura pelo título
//        UIAccessibility.post(notification: UIAccessibility.Notification.screenChanged, argument: self.navigationItem.titleView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
      //MARK: Acessibilidade dos elementos da tableView
        accessibilityElements = [passos!, tableView!, modelosTitulo!, labelObs!, primeiroModelo!, segundoModelo!, coresLabel!, coresLabelObs!, corLaranja!, corAzul!, corVerde!, corPreto!, botaoAnterior!, botaoConcluir!]
    }
    
    //Dicionário
    @IBAction func dicionario6Pagina() {
        tableView.dequeueReusableCell(withIdentifier: "textoCell")
        let indexPath = NSIndexPath(row: 0, section: 0)
        let multiCell = tableView.cellForRow(at: indexPath as IndexPath) as? TextoTableViewCell
        self.dictionary["NomeCurriculo"] = multiCell?.nomeField.text
        
        
        defaults.setValue(dictionary, forKey: "DictValue") //Saved the Dictionary in user default (colocar na troca de pag)
        print(dictionary)
        
    }
    //Navegação
    @objc func changeViewController(){
        
        let viewcontrollers = self.navigationController?.viewControllers
        
        viewcontrollers?.forEach({ (vc) in
            if  let inventoryListVC = vc as? QuintaPageViewController {
                self.navigationController!.popToViewController(inventoryListVC, animated: true)
            }
        })
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
    
    //Modelos
    @objc func acaoModelo1(){
        if !primeiroModelo.isSelected{
            primeiroModelo.setImage(UIImage(named: "modelo1Selected.png"), for: .normal)
            segundoModelo.setImage(UIImage(named: "modelo2.png"), for: .normal)
            segundoModelo.isSelected = false
            self.dictionary["Modelo"] = "Modelo 1 escolhido"
            defaults.setValue(dictionary, forKey: "DictValue") //Saved the Dictionary in user default (colocar na troca de pag)
            dicionario6Pagina()
            
        } else{
            primeiroModelo.setImage(UIImage(named: "modelo1.png"), for: .normal)
            
        }
        primeiroModelo.isSelected = !primeiroModelo.isSelected
        
    }
    
    @objc func acaoModelo2(){
        if !segundoModelo.isSelected{
            segundoModelo.setImage(UIImage(named: "modelo2Selected.png"), for: .normal)
            primeiroModelo.setImage(UIImage(named: "modelo1.png"), for: .normal)
            primeiroModelo.isSelected = false
            self.dictionary["Modelo"] = "Modelo 2 escolhido"
            defaults.setValue(dictionary, forKey: "DictValue") //Saved the Dictionary in user default (colocar na troca de pag)
            dicionario6Pagina()
        } else{
            segundoModelo.setImage(UIImage(named: "modelo2.png"), for: .normal)
            
        }
        segundoModelo.isSelected = !segundoModelo.isSelected
        
    }
    //Cores
    @objc func acaoLaranja(){
        if !corLaranja.isSelected{
            corLaranja.setImage(UIImage(named: "C-LaranjaSelected.png"), for: .normal)
            corAzul.setImage(UIImage(named: "C-Azul.png"), for: .normal)
            corVerde.setImage(UIImage(named: "C-Verde.png"), for: .normal)
            corPreto.setImage(UIImage(named: "C-Preto.png"), for: .normal)
            corAzul.isSelected = false
            corVerde.isSelected = false
            corPreto.isSelected = false
            self.dictionary["Cor"] = "Laranja"
            defaults.setValue(dictionary, forKey: "DictValue") //Saved the Dictionary in user default (colocar na troca de pag)
            print(dictionary)
        } else{
            corLaranja.setImage(UIImage(named: "C-Laranja.png"), for: .normal)
            
        }
        corLaranja.isSelected = !corLaranja.isSelected
        
    }
    @objc func acaoAzul(){
        if !corAzul.isSelected{
            corAzul.setImage(UIImage(named: "C-AzulSelected.png"), for: .normal)
            corLaranja.setImage(UIImage(named: "C-Laranja.png"), for: .normal)
            corVerde.setImage(UIImage(named: "C-Verde.png"), for: .normal)
            corPreto.setImage(UIImage(named: "C-Preto.png"), for: .normal)
            corLaranja.isSelected = false
            corVerde.isSelected = false
            corPreto.isSelected = false
            self.dictionary["Cor"] = "Azul"
            defaults.setValue(dictionary, forKey: "DictValue") //Saved the Dictionary in user default (colocar na troca de pag)
            print(dictionary)
        } else{
            corAzul.setImage(UIImage(named: "C-Azul.png"), for: .normal)
            
        }
        corAzul.isSelected = !corAzul.isSelected
        
    }
    @objc func acaoVerde(){
        if !corVerde.isSelected{
            corVerde.setImage(UIImage(named: "C-VerdeSelected.png"), for: .normal)
            corAzul.setImage(UIImage(named: "C-Azul.png"), for: .normal)
            corLaranja.setImage(UIImage(named: "C-Laranja.png"), for: .normal)
            corPreto.setImage(UIImage(named: "C-Preto.png"), for: .normal)
            corAzul.isSelected = false
            corLaranja.isSelected = false
            corPreto.isSelected = false
            self.dictionary["Cor"] = "Verde"
            defaults.setValue(dictionary, forKey: "DictValue") //Saved the Dictionary in user default (colocar na troca de pag)
            print(dictionary)
        } else{
            corVerde.setImage(UIImage(named: "C-Verde.png"), for: .normal)
            
        }
        corVerde.isSelected = !corVerde.isSelected
        
    }
    @objc func acaoPreto(){
        if !corPreto.isSelected{
            corPreto.setImage(UIImage(named: "C-PretoSelected.png"), for: .normal)
            corAzul.setImage(UIImage(named: "C-Azul.png"), for: .normal)
            corVerde.setImage(UIImage(named: "C-Verde.png"), for: .normal)
            corLaranja.setImage(UIImage(named: "C-Laranja.png"), for: .normal)
            corAzul.isSelected = false
            corVerde.isSelected = false
            corLaranja.isSelected = false
            self.dictionary["Cor"] = "Preto"
            defaults.setValue(dictionary, forKey: "DictValue") //Saved the Dictionary in user default (colocar na troca de pag)
            print(dictionary)
        } else{
            corPreto.setImage(UIImage(named: "C-Preto.png"), for: .normal)
            
        }
        corPreto.isSelected = !corPreto.isSelected
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "previewSegue" {
            if (self.dictionary["Modelo"] == "") || (self.dictionary["Cor"] == "") || (self.dictionary["NomeCurriculo"] == ""){
                print("vazio")
                let ac = UIAlertController(title: "Dados incompletos", message: "Um dos campos obrigatórios não foi preenchido", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                ac.view.tintColor = UIColor(named: "Ciano")
                present(ac, animated: true)
            } else{
                print("cheio")
                //  Repositorio.shared.salvar(nome: variavelComONomeDoCurriculo, dados: dicionario) (salvar o curriculo)
            }
            guard let vc = segue.destination as? ProntoPageViewController else { return }
            
            if let nome = dictionary["Nome"],
               let nascimento = dictionary["Data"],
               let tel = dictionary["Tel"],
               let local = dictionary["Local"],
               let email = dictionary["Email"],
               let link = dictionary["Link"],
               let objetivoProf = dictionary["Objetivo"],
               let resumoProf = dictionary["Resumo"],
               let nomeEmp = dictionary["NomeEmpresa"],
               let cargoEmp = dictionary["NomeCargo"],
               let dataIniEmp = dictionary["EmpregoDataIni"],
               let dataFimEmp = dictionary["EmpregoDataFim"],
               let detalhesEmp = dictionary["Detalhes"],
               let nomeInst = dictionary["NomeInst"],
               let cursoInst = dictionary["NomeCurso"],
               let dataIniInst = dictionary["InstDataIni"],
               let dataFimInst = dictionary["InstDataFim"],
               let realizacao = dictionary["NomeConq"],
               let descReal = dictionary["DescConq"],
               let dataIniReal = dictionary["ConqDataIni"],
               let dataFimReal = dictionary["ConqDataFim"],
               let deficiencia = dictionary["NomeDef"],
               let deficienciaObs = dictionary["ObsDef"],
               let modelo = dictionary["Modelo"],
               let cor = dictionary["Cor"]
            {
                
                
                let pdfCreator = PDFCreator(nome: nome,
                                            nascimento: nascimento,
                                            tel: tel,
                                            local: local,
                                            email: email,
                                            link: link,
                                            objetivoProf: objetivoProf,
                                            resumoProf: resumoProf,
                                            nomeEmp: nomeEmp,
                                            cargoEmp: cargoEmp,
                                            dataIniEmp: dataIniEmp,
                                            dataFimEmp: dataFimEmp,
                                            detalhesEmp: detalhesEmp,
                                            nomeInst: nomeInst,
                                            cursoInst: cursoInst,
                                            dataIniInst: dataIniInst,
                                            dataFimInst: dataFimInst,
                                            realizacao: realizacao,
                                            descReal: descReal,
                                            dataIniReal: dataIniReal,
                                            dataFimReal: dataFimReal,
                                            deficiencia: deficiencia,
                                            deficienciaObs: deficienciaObs,
                                            modelo: modelo,
                                            cor: cor)
                vc.documentData = pdfCreator.criarCurriculo()
                
            }
        }
    }
}
extension TemplatesPageViewController: UINavigationControllerDelegate {
    // Not used, but necessary for compilation
}
//TableView
extension TemplatesPageViewController: UITableViewDelegate{
    
}

extension TemplatesPageViewController: UITableViewDataSource{
    
    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "textoCell", for: indexPath) as! TextoTableViewCell
        cell.nomeLabel.text = "Nome do Currículo"
        cell.nomeField.keyboardType = .default
        cell.nomeField.placeholder = "Digite o nome do currículo"
        cell.nomeObs.text = "*Obrigatório"
        
        //MARK: Acessibilidade - Nome do currículo
        cell.nomeLabel.isAccessibilityElement = true
        cell.nomeLabel.accessibilityLabel = "Nome do currículo"
        
        cell.nomeField.isAccessibilityElement = true
        cell.nomeField.accessibilityLabel = "Digite o nome do currículo"
        
        cell.nomeObs.isAccessibilityElement = true
        cell.nomeObs.accessibilityLabel = "Este item é de preenchimento obrigatório"
        
        //MARK: Acessibilidade das células da tableView
        accessibilityElements = [cell.nomeLabel!, cell.nomeObs!, cell.nomeField!]
        
        
        if UIAccessibility.isVoiceOverRunning {
            cell.nomeField.placeholder = ""
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    
}

