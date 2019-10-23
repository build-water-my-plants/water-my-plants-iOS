//
//  PlantListTableViewController.swift
//  waterMyPlantTemp
//
//  Created by Michael Flowers on 10/18/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit
import CoreData
class PlantListTableViewController: UITableViewController {
//    var owner: Owner?
    lazy var fetchedResultsController: NSFetchedResultsController<Plant> = {
        let fetchRequest: NSFetchRequest<Plant> = Plant.fetchRequest()
        let sortDiscriptors = NSSortDescriptor(key: "schedule", ascending: true)
        fetchRequest.sortDescriptors = [sortDiscriptors]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.mainContext, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        
        do {
            try frc.performFetch()
        } catch {
            print("Error performing FRC fetchRequest in: \(#function)/// \(error.localizedDescription)")
        }
        return frc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    //
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchedResultsController.fetchedObjects?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "plantCell", for: indexPath) as! PlantCellTableViewCell
//        let owner = fetchedResultsController.object(at: indexPath)
       // guard let plant = owner.plants?[indexPath.row] as? Plant else { return UITableViewCell() }
        let plant = fetchedResultsController.object(at: indexPath)
        cell.plant = plant
        
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            guard let plantToDelete = fetchedResultsController.object(at: indexPath).plants?[indexPath.row] as? Plant else { return  }
            let plantToDelete = fetchedResultsController.object(at: indexPath)
            PlantController.delete(plant: plantToDelete)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellSegue" {
            guard let destination = segue.destination as? PlantDetailViewController, let indexPath = tableView.indexPathForSelectedRow /* let plant = fetchedResultsController.object(at: indexPath).plants?[indexPath.row] as? Plant */ else { return }
            let plant = fetchedResultsController.object(at: indexPath)
            destination.plant = plant
        } else if segue.identifier == "addSegue" {
            guard let destination = segue.destination as? PlantDetailViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
//            let owner = fetchedResultsController.object(at: indexPath)
             let plant = fetchedResultsController.object(at: indexPath)
            destination.user = plant.user
//            self.owner = plant.owner
        } else if segue.identifier == "settingSegue"{
            guard let destination = segue.destination as? SettingsViewController  else { return }
            let user = User(username: "testUSER", phoneNumber: "4304003940", password: "password")
            destination.user = user
        }
        
    }
    
    
}
extension PlantListTableViewController: NSFetchedResultsControllerDelegate {
    //will tell the tableViewController get ready to do something.
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            //there was a new entry so now we need to make a new cell.
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .move:
            guard let indexPath = indexPath, let newIndexpath = newIndexPath else {return}
            tableView.moveRow(at: indexPath, to: newIndexpath)
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            fatalError()
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            let indexSet = IndexSet(integer: sectionIndex)
            tableView.insertSections(indexSet, with: .automatic)
        case .delete:
            let indexSSet = IndexSet(integer: sectionIndex)
            tableView.deleteSections(indexSSet, with: .automatic)
        default:
            break
        }
    }
}
