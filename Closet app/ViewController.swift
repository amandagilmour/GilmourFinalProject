//
//  ViewController.swift
//  Closet app
//
//  Created by Amanda Gilmour on 4/21/17.
//  Copyright © 2017 Amanda Gilmour. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func switchView(group: String) {
        let nav = storyboard!.instantiateViewController(withIdentifier: "CategoryView") as! UINavigationController
        let category = nav.viewControllers[0] as! CategoryViewController
        category.cat = group
        self.present(nav, animated: true, completion: nil)
    }

    
    
    @IBAction func shirtGroup(_ sender: UIButton) {
        switchView(group: "Shirts")
    }

    @IBAction func pantsGroup(_ sender: UIButton) {
        switchView(group: "Pants")
    }
    
    @IBAction func dressesGroup(_ sender: UIButton) {
        switchView(group: "Dresses/Skirts")
    }
    
    @IBAction func accessoriesGroup(_ sender: UIButton) {
        switchView(group: "Accessories")
    }
    
    
    
    
}

