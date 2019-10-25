//
//  PlantTableViewController.swift
//  ios-WaterMyPlants
//
//  Created by Joe Thunder on 10/19/19.
//  Copyright © 2019 LambdaSchool. All rights reserved.
//

import UIKit

class PlantTableViewController: UITableViewController {
    
    var plants: [Plants] = []
    var user: Accounts = Accounts(user: "", password: "")
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let aloevera = Plants(name: "Aloe vera")
        let eucalyptus = Plants(name: "Eucalyptus")
        plants.append(aloevera)
        plants.append(eucalyptus)
        
        if user.user == "" {
            performSegue(withIdentifier: "ToLogin", sender: self)
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return plants.count
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return plants.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlantCell", for: indexPath) as? PlantTableViewCell else {return PlantTableViewCell()}

        let plantInfo = plants[indexPath.row]
        cell.plant = plantInfo
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToLogin" {
            if let loginVC = segue.destination as? LoginViewController {
                loginVC.delegate = self.user
            }
        }
    }
    

}
