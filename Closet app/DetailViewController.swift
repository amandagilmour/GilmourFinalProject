//
//  DetailViewController.swift
//  Closet app
//
//  Created by Amanda Gilmour on 5/1/17.
//  Copyright © 2017 Amanda Gilmour. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    let imagePreview = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePreview.frame = CGRect(x: 75, y: 150, width: self.view.frame.width-150, height: self.view.frame.width-150)
        imagePreview.contentMode = .scaleAspectFit
        self.view.addSubview(imagePreview)

        // Do any additional setup after loading the view.
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



    @IBOutlet weak var deleteButton: UIButton!
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
