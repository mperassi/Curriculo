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
    
    private var curriculos: [Curriculo] = []
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var botaoAdd: UIBarButtonItem!
    @IBOutlet var collectionView: UICollectionView!
    let fraseSemCurriculo = UILabel()
    let imagemBoasVindas = UIImageView()
    
    //    private lazy var frc: NSFetchedResultsController<Curriculo> = {
    //        let fetchRequest: NSFetchRequest<Curriculo> = Curriculo.fetchRequest()
    ////        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Trip.name, ascending: true)]
    //
    //        let frc = NSFetchedResultsController<Curriculo>(fetchRequest: fetchRequest,
    //                                                        managedObjectContext: CurriculoRepositorio.shared.,
    //                                                   sectionNameKeyPath: nil,
    //                                                   cacheName: nil)
    //        frc.delegate = self
    //        return frc
    //    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(fraseSemCurriculo)
        view.addSubview(imagemBoasVindas)
        //
        //        do {
        //            try frc.performFetch()
        //        } catch {
        //            print("Não foi")
        //        }
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
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
        //        botaoAdd = UIBarButtonItem(image: UIImage(systemName: "plus"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(actNewTrip))//
        
        
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        self.curriculos = CurriculoRepositorio.shared.buscarTodos()
        //(lista dos curriculos collection)
        self.collectionView.reloadData()
        numeroDeCelulas()
    }
    //    //MARK: Label de nenhuma viagem
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
    //MARK: Função de chamar a controller de Novo Curriculo
    //    @objc func actNewTrip() -> Void{
    //        let root = NewTripViewController(type: .firstView)
    //        let vc = UINavigationController(rootViewController: root)
    //        vc.modalPresentationStyle = .automatic
    //        present(vc, animated: true, completion: {[weak self] in self?.numeroDeCelulas()})
    //    }
}
extension BemvindosViewController: UICollectionViewDelegate{
    
}

extension BemvindosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("numero de celssss: ", self.curriculos.count)
        return self.curriculos.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! InicioCollectionViewCell
        return cell
    }
    //        let curriculo = CurriculoRepositorio.shared.buscar(nome: "oi")
    // (pegar 1 curriculo)
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 240)
    }
    
}
//
//
//
//    //MARK: CollectionView Delegate
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let numberOfCollections = frc.fetchedObjects?.count ?? 0
//        return numberOfCollections
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TripCollectionViewCell else {preconditionFailure()}
//
//        let object = frc.object(at: indexPath)
//        cell.img.image = UIImage(data: object.coverImage ?? Data()) ?? imgFundo
//        cell.name.text = object.name
//        return cell
//    }
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch type {
//        case .insert:
//            if let newIndexPath = newIndexPath {
//                collectionView?.insertItems(at: [newIndexPath])
//            }
//        case .delete:
//            if let indexPath = indexPath {
//                collectionView?.deleteItems(at: [indexPath])
//            }
//        default:
//            break
//        }
//        collectionView?.reloadData()
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let object = frc.object(at: indexPath)
//        let vc = TripViewController(tripInfos: object)
//        navigationController?.pushViewController(vc, animated: true)
// let curriculo = Repositorio.shared.buscar(nome: nomeEscolhido) (pegar 1 curriculo)

//    }
//
//}

