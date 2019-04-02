//
//  Json_TableViewController.swift
//  MachineTest
//
//  Created by FM-MAC5 on 04/07/18.
//  Copyright © 2018 FM-MAC5. All rights reserved.
//

import UIKit

class Json_TableViewController: UITableViewController {
var contactarry = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      DataTask()
    }
    func DataTask()
    {
        var url = URL(string:"https://api.androidhive.info/contacts/")
        var request = URLRequest(url: url!)
    request.httpMethod = "GET"
        var session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { (data : Data?, response : URLResponse?, error: Error?) -> Void in
            if error != nil
            {
                print(data)
                print("error occured while parsing")
            }
            
            do
            {
                let rootdir = try! JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.mutableContainers)as! NSDictionary
                print(rootdir)
                var arrayobject = rootdir.value(forKey: "contacts")as! NSArray
                for items in arrayobject
                {
                    var tempobj = Contact()
                var tempdata = items as! NSDictionary
                    tempobj.name = tempdata.value(forKey: "name")as! String
                    var phone = tempdata.value(forKey: "phone")as! NSDictionary
                    
                        tempobj.number = phone.value(forKey: "mobile")as! String
                        
                    
                        self.contactarry.append(tempobj)
                    
                }
               self.tableView.reloadData()
            }
            
            
            
        })
        
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contactarry.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var temp = contactarry[indexPath.row]
        cell.textLabel?.text = temp.name
        cell.detailTextLabel?.text = temp.number
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
