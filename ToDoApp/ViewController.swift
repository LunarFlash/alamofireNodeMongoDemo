//
//  ViewController.swift
//  ToDoApp
//
//  Created by Terry Wang on 1/12/16.
//  Copyright © 2016 Vento. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var jsonArray:NSMutableArray?
    var newArray: Array<String> = []
    
    var IDArray: Array<String> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Alamofire.request(.GET, Routes.todo).responseJSON { response in debugPrint(response) }
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchAndUpdate()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = self.newArray[indexPath.row]
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Helper
    func fetchAndUpdate () {
        
        
        self.newArray.removeAll()
        self.IDArray.removeAll()
        
        Alamofire.request(.GET, Routes.todo  ) .responseJSON { response in // 1
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                self.jsonArray = JSON as? NSMutableArray
                
                
                print(self.jsonArray)
                
                
                
                //if self.jsonArray?.count > 0 {
                    for item in self.jsonArray! {
                        print(item["name"]!)
                        let string = item["name"]!
                        print("String is \(string!)")
                        
                        let ID = item["_id"]!
                        
                        
                        
                        
                        self.newArray.append(string! as! String)
                        self.IDArray.append(ID! as! String)
                    }
                //}
                print("New array is \(self.newArray)")
                self.tableView.reloadData()
            }
            
            
        }
        
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            print("ID is \(self.IDArray[indexPath.row])")
            Alamofire.request(.DELETE, "\(Routes.todo)\(self.IDArray[indexPath.row])")
            self.fetchAndUpdate()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
        
        
    }
    
    @IBAction func refreshBarButtonItemPressed(sender: AnyObject) {
        self.fetchAndUpdate()
    }
    
    
}

