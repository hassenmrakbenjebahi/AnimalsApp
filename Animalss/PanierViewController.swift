//
//  PanierViewController.swift
//  Animalss
//
//  Created by Mac Mini on 14/1/2024.
//

import UIKit
import CoreData
class PanierViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    var animals = [String]()
    
    
    @IBOutlet weak var tablefav: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSuspects()
        tablefav.reloadData()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "mCelll")
        let cv=cell?.contentView
        
        let imageAn=cv?.viewWithTag(1) as! UIImageView
        let nameAn=cv?.viewWithTag(2) as! UILabel
        
        imageAn.image=UIImage(named: animals[indexPath.row])
        nameAn.text=animals[indexPath.row]
        
        return cell!
    }
    
    
    
    
 
    func fetchSuspects()  {
        
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let persistentContainer=appDelegate.persistentContainer
        let managedContext=persistentContainer.viewContext
        
        let request=NSFetchRequest<NSManagedObject>(entityName: "Animal")
        
        do{
           let result = try managedContext.fetch(request)
            for item in result{
            
              
                animals.append(item.value(forKey: "name") as! String)
                   print(animals)
               
            }

        }catch{
            print("topPlayers fetching error")
        }
    }
    
 
    // this method handles row deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        let selectedProduct=animals[indexPath.row]
        if editingStyle == .delete {

          
               

            let confirmationAlert = UIAlertController(title: "Animal DELETED", message: "Voulez vous suprimer cet animal?", preferredStyle: .alert)

            confirmationAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            confirmationAlert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { [weak self] _ in
                // Delete the suspect from Core Data
                self?.deleteSuspectFromCoreData(at: indexPath.row)

                // Remove the suspect from the arrays
                self?.animals.remove(at: indexPath.row)

                // Delete the table view row
                tableView.deleteRows(at: [indexPath], with: .fade)
          
              
            }))

            present(confirmationAlert, animated: true, completion: nil)
         }
     }
    func deleteSuspectFromCoreData(at index: Int) {
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
         let persistentContainer = appDelegate.persistentContainer
         let managedContext = persistentContainer.viewContext

         let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Animal")
         request.predicate = NSPredicate(format: "name == %@", animals[index])

         do {
             let result = try managedContext.fetch(request)
             if let objectToDelete = result.first as? NSManagedObject {
                 managedContext.delete(objectToDelete)

                 // Save the changes
                 try managedContext.save()
             }
         } catch {
             print("Error deleting suspect from Core Data: \(error)")
         }
     }


   
    
  
    
    

  

}
