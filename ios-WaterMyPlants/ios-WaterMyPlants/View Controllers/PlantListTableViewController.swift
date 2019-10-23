//
//  PlantListTableViewController.swift
//  ios-WaterMyPlants
//
//  Created by Michael Flowers on 10/23/19.
//  Copyright © 2019 LambdaSchool. All rights reserved.
//

import UIKit
import CoreData
class PlantListTableViewController: UITableViewController {

    //MARK: - Properties
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
        let plant = fetchedResultsController.object(at: indexPath)
        // Configure the cell...
        cell.plant = plant

        return cell
    }
  
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
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
                }
    }
  

}

extension PlantListTableViewController: NSFetchedResultsControllerDelegate {
    //MARK: - NSFetchControllerResults
 
        //tell the tableView I'm about to do a bunch of stuff
        func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            tableView.beginUpdates()
        }
        //tell tableView I finished doing my stuff, you do your thing
        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            tableView.endUpdates()
        }
        //I just created,read, update or deleted something
        func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                        didChange anObject: Any,
                        at indexPath: IndexPath?,
                        for type: NSFetchedResultsChangeType,
                        newIndexPath: IndexPath?) {
            switch type {
            case .insert:
                guard let newIndexPath = newIndexPath else {return}
                tableView.insertRows(at: [newIndexPath ], with: .automatic)
            case .delete:
                guard let oldIndexPath = indexPath else {return}
                tableView.deleteRows(at: [oldIndexPath], with: .automatic)
            case .update:
                guard let oldIndexPath = indexPath else {return}
                tableView.reloadRows(at: [oldIndexPath], with: .automatic)
            case .move:
                guard let oldIndexPath = indexPath,
                    let newIndexPath = indexPath else {return}
                tableView.moveRow(at: oldIndexPath, to: newIndexPath)
            @unknown default:
                fatalError()
            }
        }
        
        //i just changed the  number of sections
        //why is this important?
        func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                        didChange sectionInfo: NSFetchedResultsSectionInfo,
                        atSectionIndex sectionIndex: Int,
                        for type: NSFetchedResultsChangeType) {
            let indexSet = IndexSet(integer: sectionIndex)
            switch type {
            case .insert:
                tableView.insertSections(indexSet, with: .automatic)
            case .delete:
                tableView.deleteSections(indexSet, with: .automatic)
            default:
                return
            }
        }

}
