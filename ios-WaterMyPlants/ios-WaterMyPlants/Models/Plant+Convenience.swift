//
//  Plant+Convenience.swift
//  ios-WaterMyPlants
//
//  Created by Michael Flowers on 10/22/19.
//  Copyright © 2019 LambdaSchool. All rights reserved.
//

import Foundation
import CoreData

extension Plant {
    convenience init(name: String, species: String, photo: Data? = nil, schedule: Date, context: NSManagedObjectContext = CoreDataStack.shared.mainContext){
        self.init(context: context)
        self.name = name
        self.species = species
        self.schedule = schedule
        self.photo = photo
    }
}
