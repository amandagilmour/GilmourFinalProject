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
    
    var cat: String!
    
    var closetImagesArray: [UIImage] = []
    
    var shirtsImagesArray: [UIImage] = []
    
    var pantsImagesArray: [UIImage] = []
    
    var dressesImagesArray: [UIImage] = []
    
    var accessoriesImagesArray: [UIImage] = []
    
    var defaultsData = UserDefaults.standard

    struct ImageAndURL {
        var image: UIImage!
        var url: String!
    }
    
    var structArray = [ImageAndURL]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hi")
        collView.delegate = self
        collView.dataSource = self
        collView.reloadData()
        
        
        //checkWhichCategory()
        readingImages()
        showEmptyCloset()
        self.title = cat
    }

    func showEmptyCloset() {
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
    
    func writeData(image: UIImage, name: String) {
        if let imageData = UIImagePNGRepresentation(image) {
            let fileName = NSUUID().uuidString // always creates unique string in part based on time/date
            let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let writePath = documents.appending(fileName)
            do {
                try imageData.write(to: URL(fileURLWithPath: writePath))
                structArray.append(ImageAndURL(image: image, url: fileName))
                let urlArray = structArray.map {$0.url}
                defaultsData.set(urlArray, forKey: name)
            } catch {
                print("Error in trying to write imageData to imageURL = \(writePath)")
            }
            
        } else {
            print("Error in trying to convert image into data")
        }
    }
    
    
    func deleteData(index: Int, name: String) {
        let fileManager = FileManager.default
        let fileName = structArray[index].url
        let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let deletePath = documents.appending(fileName!)
        do {
            try fileManager.removeItem(atPath: deletePath)
            structArray.remove(at: index)
            closetImagesArray.remove(at: index)
            self.collView.reloadData()
            let urlArray = structArray.map {$0.url}
            defaultsData.set(urlArray, forKey: name)
        } catch {
            print("Error in trying to delete imageData to imageURL = \(deletePath)")
        }
        
    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func readData(name: String) {
        if let urlArray = defaultsData.object(forKey: name) as? [String] {
            
            for index in 0..<urlArray.count {
                
                let fileManager = FileManager.default
                let imagePath = getDirectoryPath() + urlArray[index]
                if fileManager.fileExists(atPath: imagePath) {
                    let newImage = UIImage(contentsOfFile: imagePath as String)
                    structArray.append(ImageAndURL(image: newImage, url: urlArray[index]))
                } else {
                    print("No Image")
                }
            }
        }
    }
    
    func readingImages() {
        readData(name: cat)
        for s in structArray {
            closetImagesArray.append(s.image)
        }
    }
    
    func checkWhichCategory() {
        if cat == "Shirts" {
            readData(name: "shirtPhotos")
            closetImagesArray = shirtsImagesArray
            
        } else if cat == "Pants" {
            readData(name: "pantPhotos")
            closetImagesArray = pantsImagesArray
        } else if cat == "Dresses/Skirts" {
            readData(name: "dressPhotos")
            closetImagesArray = dressesImagesArray
        } else if cat == "Accessories" {
            readData(name: "accessoryPhotos")
            closetImagesArray = accessoriesImagesArray
        }
    }
    
    
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func unwindToCategoryViewController(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddImageViewController, let image = sourceViewController.newImage {
                self.closetImagesArray.append(image.image!)
            self.writeData(image: image.image!, name: cat)
            self.collView.reloadData()
            showEmptyCloset() 
            }
            
            //defaultsData.set(closetImagesArray, forKey: "closetImagesArray")
            
        }
    @IBAction func unwindFromDetailVC(sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindToDelete(sender: UIStoryboardSegue) {
        self.deleteData(index: (self.collView.indexPathsForSelectedItems?[0].item)!, name: cat)
        self.showEmptyCloset()
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
        return CGSize(width: (self.view.frame.width)/2 - 20, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let VC = storyboard!.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        VC.imagePreview.image = closetImagesArray[indexPath.item]
        
        self.present(VC, animated: true, completion: nil)
    }

}




