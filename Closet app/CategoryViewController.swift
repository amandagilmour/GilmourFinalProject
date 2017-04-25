//
//  CategoryViewController.swift
//  Closet app
//
//  Created by Amanda Gilmour on 4/21/17.
//  Copyright © 2017 Amanda Gilmour. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var collView: UICollectionView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var cat: Int!
    
    var closetImagesArray: [UIImage] = []
    
    var defaultsData = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hi")
        collView.delegate = self
        collView.dataSource = self
        collView.reloadData()
        
        if closetImagesArray.count == 0 {
            collView.isHidden = true
            imageView.isHidden = false
        } else {
            collView.isHidden = false
            imageView.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func unwindToCategoryViewController(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddImageViewController, let image = sourceViewController.newImage {
                self.closetImagesArray.append(image.image!)
            self.collView.reloadData()
            }
            
            //defaultsData.set(closetImagesArray, forKey: "closetImagesArray")
            
        }
    }

extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("hello")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.savedImage.image = closetImagesArray[indexPath.row]
        print(closetImagesArray.count)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return closetImagesArray.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width)/3 - 20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}




