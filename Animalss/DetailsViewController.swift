//
//  DetailsViewController.swift
//  Animalss
//
//  Created by Mac Mini on 14/1/2024.
//

import UIKit
import CoreData
class DetailsViewController: UIViewController {
    
    var animalName:String?
    var animalType:String?
    
    
    @IBOutlet weak var img1: UIImageView!
    
    
    @IBOutlet weak var label: UILabel!
    
    
    @IBOutlet weak var acc1: UIImageView!
    
    
    @IBOutlet weak var btn: UIButton!
    
    
    @IBOutlet weak var acc2: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        img1.image = UIImage(named: animalName!)
        label.text = animalName!
        
        if animalType == "chat"{
            acc1.image = UIImage(named: "chataccess1")
            acc2.image = UIImage(named: "chatacces2")

        }else{
            btn.backgroundColor = UIColor.systemMint
            acc1.image = UIImage(named: "chienacces1")
            acc2.image = UIImage(named: "chienacces2")
        }
   
    }
    
    //IBAction
    func isAdded() -> Bool {
        var mBoolean=false
        
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let persistentContainer=appDelegate.persistentContainer
        let managedContext=persistentContainer.viewContext
        
        let request=NSFetchRequest<NSManagedObject>(entityName: "Animal")
        let predicate=NSPredicate(format: "name = %@", animalName!)
        request.predicate=predicate
        
        do{
           let result = try managedContext.fetch(request)
            if result.count>0{
                mBoolean=true
            }

        }catch{
            print("Animal fetching error")
        }
        
        return mBoolean
    }
    
    
    
    func addPlayer() {
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let persistentContainer=appDelegate.persistentContainer
        let managedContext=persistentContainer.viewContext
        
        let entityDescription=NSEntityDescription.entity(forEntityName: "Animal", in: managedContext)
        let object=NSManagedObject(entity: entityDescription!, insertInto: managedContext)
        object.setValue(animalName, forKey: "name")
       
        
        do{
            try managedContext.save()
            self.showAlert(title: "INSERT SUCCESSFULLY", message: "Animal  ajouter au panier")
        }catch{
            print("Product adding error")
        }
    }
    
    
    
    func showAlert(title:String,message:String) {
        let alert=UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
   
    @IBAction func AjouterPanier(_ sender: Any) {
        
        if(!isAdded()){
                
            addPlayer()
            
        }else{
            self.showAlert(title: "Animal EXISTS", message: "Animal deja ajouter!")
        }
    }
    
    

}
