//
//  BemVindosViewcontroller.swift
//  Curriculo
//
//  Created by Gabriele Namie on 27/09/21.
//

import Foundation
import UIKit
import CoreData

class BemvindosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet var scrollView: UIScrollView!
    //    @IBOutlet weak var fraseSemCurriculo: UILabel!
    @IBOutlet weak var botaoAdd: UIBarButtonItem!
    //    @IBOutlet weak var imagemBoasVindas: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! InicioCollectionViewCell
        return cell
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        //CollectionView
        //        collectionView.register(InicioCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        
        //        fraseSemCurriculo.numberOfLines = 0
        //        fraseSemCurriculo.textAlignment = .center
        //
        //
        //        //Acessibilidade
        //        fraseSemCurriculo.isAccessibilityElement = true
        //        fraseSemCurriculo.accessibilityLabel = "Clique no botão Adicionar no canto superior direito para criar seu primeiro currículo."
        //
        //        botaoAdd.isAccessibilityElement = true
        //        botaoAdd.accessibilityLabel = "Adicionar novo currículo"
        //
        //        imagemBoasVindas.isAccessibilityElement = true
        //        imagemBoasVindas.accessibilityLabel = "Foto centralizada de uma mulher negra, cadeirante, vestindo um conjunto de moletom de cor azul, com um tênis vermelho. A mulher está com a mão direita na roda da cadeira e a mão direita acenando. Imediatamente atrás da mulher, há duas formas geométricas arredondadas de cor azul e amarela."
        //
        //        accessibilityElements = [imagemBoasVindas!,fraseSemCurriculo!, botaoAdd!]
        //
        //        if UIAccessibility.isVoiceOverRunning {
        //            fraseSemCurriculo.text = ""
        //
        //
        //
        //        }
    }
}
////
////  ViewController.swift
////  BTravellr
////
////  Created by Rebecca Mello on 12/07/21.
////
//
//import UIKit
//import CoreData
//
//class FirstSceneViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {

//
//    private let coreData = CoreDataStack.shared
//    var imgFundo: UIImage = UIImage(named: "collectionBg")!
//    let plane: UIImageView = {
//        let theImageView = UIImageView()
//        theImageView.translatesAutoresizingMaskIntoConstraints = false
//        theImageView.image = UIImage(named: "HomePlane")
////        theImageView.contentMode = .scaleAspectFit
//        return theImageView
//    }()
//
//
//
//    private lazy var frc: NSFetchedResultsController<Trip> = {
//        let fetchRequest: NSFetchRequest<Trip> = Trip.fetchRequest()
//        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Trip.name, ascending: true)]
//
//        let frc = NSFetchedResultsController<Trip>(fetchRequest: fetchRequest,
//                                                    managedObjectContext: coreData.mainContext,
//                                                    sectionNameKeyPath: nil,
//                                                    cacheName: nil)
//        frc.delegate = self
//        return frc
//    }()
//
//    //MARK: DidLoad

//        but = UIBarButtonItem(image: UIImage(systemName: "plus"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(actNewTrip))
//        navigationItem.rightBarButtonItem = but!
//
//
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//
//        guard let collectionView = collectionView else {
//            return
//        }
//
//        collectionView.register(TripCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.backgroundColor = .clear
//
//        do {
//            try frc.performFetch()
//        } catch {
//            print("Não foi")
//        }
//
//
//    }
//
//    //MARK: Label de nenhuma viagem
//    override func viewWillAppear(_ animated: Bool) {
//        reactNumbeOftrips()
//    }
//
//    func reactNumbeOftrips(){
//        if Int(frc.fetchedObjects?.count ?? 1000) != 0 {
//            noTripLabel.isHidden = true
//            plane.isHidden = true
//            bags.isHidden = true
//        }
//        else{
//            noTripLabel.isHidden = false
//            plane.isHidden = false
//            bags.isHidden = false
//        }
//    }
//
//    //MARK: Função de chamar a controller de Nova Viagem
//    @objc func actNewTrip() -> Void{
//        let root = NewTripViewController(type: .firstView)
//        let vc = UINavigationController(rootViewController: root)
//        vc.modalPresentationStyle = .automatic
//        present(vc, animated: true, completion: {[weak self] in self?.reactNumbeOftrips()})
//    }
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
//    }
//
//}
//
//extension FirstSceneViewController: NewTripViewControllerDelegate {
//    func didRegister() {
//        collectionView?.reloadData()
//    }
//}
