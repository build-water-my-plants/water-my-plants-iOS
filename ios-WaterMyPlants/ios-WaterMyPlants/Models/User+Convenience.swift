//
//  User+Convenience.swift
//  ios-WaterMyPlants
//
//  Created by Michael Flowers on 10/22/19.
//  Copyright © 2019 LambdaSchool. All rights reserved.
//

import Foundation
import CoreData

extension User {
    convenience init(username: String, phoneNumber: String, password: String, plants: [Plant] = [], context: NSManagedObjectContext = CoreDataStack.shared.mainContext){
        self.init(context: context)
        self.username = username
        self.phoneNumber = phoneNumber
        self.password = password
        //don't have to initialize plants because we gave it a default value in a convenience initializer
    }
}
