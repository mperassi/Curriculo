//
//  CurriculoRepositorio.swift
//  Curriculo
//
//  Created by Carolina Ortega on 01/10/21.
//

import Foundation
import CoreData

class Repositorio {
    static let shared: Repositorio = Repositorio()
    private init() {}
    
    // MARK: - Core Data stack
    //Carrega as informações do nosso arquivo de coredata
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Curriculo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    //Filas de conexão onde eu posso fazer ações como gravar e ler algum dado
    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func salvar(nome: String, dados: [String: String]) {
        let curriculo = Curriculo(context: self.persistentContainer.viewContext)
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(dados) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                curriculo.dados = jsonString
                curriculo.nome = nome
            }
        }
        self.saveContext()
        
    }
    
    func buscar(nome: String) -> [String: String]? {
        let fetch = NSFetchRequest<Curriculo>(entityName: "Curriculo")
        fetch.predicate = NSPredicate(format: "nome == %@", nome)
        do {
            let result = try fetch.execute()
            if result.count > 0 {
                return self.converter(curriculo: result[0])
            }
        }catch {
            print(error)
        }
        return nil
    }
    
    /**
     Creates a personalized greeting for a recipient.

     - Parameter recipient: The person being greeted.

     - Throws: `MyError.invalidRecipient`
               if `recipient` is "Derek"
               (he knows what he did).

     - Returns: A new string saying hello to `recipient`.
     */
    func buscarTodos() -> [String] {
        let fetch = NSFetchRequest<Curriculo>(entityName: "Curriculo")
        do {
            let r = try fetch.execute()
            return r.map { c in
                return c.nome!
            }
        }catch {
            print(error)
        }
        return []
    }

    
    private func converter(curriculo: Curriculo) -> [String: String] {
        if let data = curriculo.dados!.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:String]
                return json!
            } catch {
                print("Something went wrong")
            }
        }
        return [:]
    }

}
