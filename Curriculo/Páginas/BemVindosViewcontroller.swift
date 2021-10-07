//
//  BemVindosViewcontroller.swift
//  Curriculo
//
//  Created by Gabriele Namie on 27/09/21.
//


import Foundation
import UIKit
import CoreData

class BemvindosViewController: UIViewController, NSFetchedResultsControllerDelegate, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: BemvindosViewController?
    private var curriculos: [String] = []
    
    @IBAction func deleteItem(_ sender: Any) {
//        Alerta
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Apagar Currículo", style: .destructive, handler: {(action:UIAlertAction!) in
            if let selectedCells = self.collectionView.indexPathsForSelectedItems {
                // 1 The selected cells will be reversed and sorted so the items with the highest index will be removed first.
                let items = selectedCells.map { $0.item }.sorted().reversed()
                // 2 The items will be removed from the modelData array
                for item in items {
                    let _ = try? CurriculoRepositorio.shared.delete(nome: self.curriculoSelecionado)
                    self.curriculos.remove(at: item)
                }
                // 3 The selected cells will be reversed and sorted so the items with the highest index will be removed first.
                self.collectionView.deleteItems(at: selectedCells)
                self.botaoDelete.isEnabled = false
              }
        }))
        ac.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        present(ac, animated: true)

    }
    
    
    @IBOutlet var toolBar: UIToolbar!
    @IBOutlet var botaoDelete: UIBarButtonItem!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var botaoAdd: UIBarButtonItem!
    @IBOutlet var collectionView: UICollectionView!
    let fraseSemCurriculo = UILabel()
    let imagemBoasVindas = UIImageView()
    var curriculoSelecionado: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(fraseSemCurriculo)
        view.addSubview(imagemBoasVindas)

        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationItem.leftBarButtonItem = editButtonItem
        self.navigationItem.leftBarButtonItem?.title = "Editar"
        
        toolBar.isHidden = true
        
        //CollectionView
        guard let collectionView = collectionView else {
            return
        }
        collectionView.register(InicioCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        
        botaoAdd.isAccessibilityElement = true
        botaoAdd.accessibilityLabel = "Adicionar novo currículo"
        
        
        imagemBoasVindas.isAccessibilityElement = true
        imagemBoasVindas.image = UIImage(named: "fotoInicio")
        imagemBoasVindas.accessibilityLabel = "Foto centralizada de uma mulher negra, cadeirante, vestindo um conjunto de moletom de cor azul, com um tênis vermelho. A mulher está com a mão direita na roda da cadeira e a mão direita acenando. Imediatamente atrás da mulher, há duas formas geométricas arredondadas de cor azul e amarela."
        imagemBoasVindas.translatesAutoresizingMaskIntoConstraints = false
        
        imagemBoasVindas.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        imagemBoasVindas.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        fraseSemCurriculo.text = "Clique em ”Adicionar” para criar seu primeiro currículo!"
        fraseSemCurriculo.numberOfLines = 0
        fraseSemCurriculo.textAlignment = .center
        fraseSemCurriculo.textColor = .darkGray
        fraseSemCurriculo.isAccessibilityElement = true
        fraseSemCurriculo.accessibilityLabel = "Clique no botão Adicionar no canto superior direito para criar seu primeiro currículo."
        fraseSemCurriculo.translatesAutoresizingMaskIntoConstraints = false
        fraseSemCurriculo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35).isActive = true
        fraseSemCurriculo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35).isActive = true
        fraseSemCurriculo.topAnchor.constraint(equalTo: imagemBoasVindas.bottomAnchor, constant: 35).isActive = true
        
        accessibilityElements = [imagemBoasVindas,fraseSemCurriculo, botaoAdd!]
        
        if UIAccessibility.isVoiceOverRunning {
            fraseSemCurriculo.text = ""
            
        }
        
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        collectionView.allowsMultipleSelection = editing
        let indexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in indexPaths {
            let cell = collectionView.cellForItem(at: indexPath) as! InicioCollectionViewCell
            cell.isInEditingMode = editing
        }
        if (self.isEditing) {
            self.editButtonItem.title = "OK"
            toolBar.isHidden = false
            }
            else {
                self.editButtonItem.title = "Editar"
                toolBar.isHidden = true
                
            }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.curriculos = CurriculoRepositorio.shared.buscarTodos()
        //(lista dos curriculos collection)
        self.collectionView.reloadData()
        numeroDeCelulas()
    }
    //    //MARK: Label de nenhum curriculo
    func numeroDeCelulas(){
        if Int(self.curriculos.count) != 0 {
            fraseSemCurriculo.isHidden = true
            imagemBoasVindas.isHidden = true
            collectionView.isHidden = false
            
        }
        else{
            fraseSemCurriculo.isHidden = false
            imagemBoasVindas.isHidden = false
            collectionView.isHidden = true
            
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCurriculo" {
            guard let vc = segue.destination as? VisualizarPageViewController,
                  let curriculo = self.curriculoSelecionado,
                  let dictionary = CurriculoRepositorio.shared.buscar(nome: curriculo)
            else { return }
            
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

extension BemvindosViewController: UICollectionViewDelegate{
    func didRegister(){
        collectionView?.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.curriculoSelecionado = self.curriculos[indexPath.row]

        if !isEditing {
            botaoDelete.isEnabled = false
            performSegue(withIdentifier: "ShowCurriculo", sender: self)
        } else {
            botaoDelete.isEnabled = true

        }


    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let selectedItems = collectionView.indexPathsForSelectedItems, selectedItems.count == 0 {
                botaoDelete.isEnabled = false
            }
    }
    
}

extension BemvindosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.curriculos.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! InicioCollectionViewCell
        cell.apelido.text = curriculos[indexPath.row]
        if let dict = CurriculoRepositorio.shared.buscar(nome: curriculos[indexPath.row]), let cor = dict["Cor"] {
            cell.cor(cor)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 240)
    }
    
}

