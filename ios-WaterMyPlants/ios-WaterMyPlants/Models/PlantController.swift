//
//  PlantController.swift
//  ios-WaterMyPlants
//
//  Created by Michael Flowers on 10/23/19.
//  Copyright © 2019 LambdaSchool. All rights reserved.
//

import Foundation

class PlantController {
    static let shared = PlantController()
    static func createPlantWith(name: String, species: String, photo: Data?, schedule: Date, user: User){
        _ = Plant(name: name, species: species, photo: photo, schedule: schedule, user: user)
        UserController.shared.saveToPersistentStore()
    }
    
    static func delete(plant: Plant){
        plant.managedObjectContext?.delete(plant)
         UserController.shared.saveToPersistentStore()
    }
    
    static func update(plant: Plant, withNewName name: String, withNewSpecies species: String, withNewSchedule schedule: Date, withNewPhoto photo: Data?){
        plant.name = name
        plant.species = species
        plant.schedule = schedule
        plant.photo = photo
        UserController.shared.saveToPersistentStore()
    }
}
