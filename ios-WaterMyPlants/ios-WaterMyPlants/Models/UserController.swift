//
//  UserController.swift
//  ios-WaterMyPlants
//
//  Created by Michael Flowers on 10/23/19.
//  Copyright © 2019 LambdaSchool. All rights reserved.
//

import Foundation

class UserController {
    static let shared = UserController()
    
    func createUserWith(username: String, phoneNumber: String, password: String){
        _ = User(username: username, phoneNumber: phoneNumber, password: password)
        saveToPersistentStore()
    }
    
    func delete(user: User){
        user.managedObjectContext?.delete(user)
        saveToPersistentStore()
    }
    
    func update(user: User, username: String, password: String){
        user.username = username
        user.password = password
    }
    
    func saveToPersistentStore(){
        do {
            try CoreDataStack.shared.mainContext.save()
        } catch  {
                print("Error in: \(#function)\n Readable Error: \(error.localizedDescription)\n Technical Error: \(error)")
        }
    }
}
