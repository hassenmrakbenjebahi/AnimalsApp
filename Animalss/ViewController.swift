//
//  ViewController.swift
//  Animalss
//
//  Created by Mac Mini on 14/1/2024.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
    var Animals = ["persan","labrador","husky","siamoi","radgoll"]
    var typeAnimals = ["chat","chien","chien","chat","chat"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Animals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mcell", for: indexPath)
        let contentView = cell.contentView
        let imageView = contentView.viewWithTag(1) as! UIImageView
        let label = contentView.viewWithTag(2) as! UILabel
        
        imageView.image = UIImage(named: Animals[indexPath.row])
        label.text = Animals[indexPath.row]
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="firstSegue"{
            let index=sender as! IndexPath
            let destination=segue.destination as! DetailsViewController
            destination.animalName=Animals[index.row]
            destination.animalType=typeAnimals[index.row]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        performSegue(withIdentifier: "firstSegue", sender: indexPath)
        
      }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

