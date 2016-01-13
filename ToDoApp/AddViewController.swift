//
//  AddViewController.swift
//  ToDoApp
//
//  Created by Terry Wang on 1/12/16.
//  Copyright © 2016 Vento. All rights reserved.
//

import UIKit
import Alamofire

class AddViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addBarButtonItemPressed(sender: AnyObject) {
        Alamofire.request(.POST, Routes.todo, parameters: ["name": self.textField.text!])
        
        self.navigationController!.popViewControllerAnimated(true)
        
    }
}
