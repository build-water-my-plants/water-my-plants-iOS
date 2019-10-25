//
//  PlantTableViewCell.swift
//  ios-WaterMyPlants
//
//  Created by Joe Thunder on 10/19/19.
//  Copyright © 2019 LambdaSchool. All rights reserved.
//

import UIKit

class PlantTableViewCell: UITableViewCell {
    
    @IBOutlet weak var plantLabel: UILabel!
    
    var plant: Plants? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let plant = plant else {return}
        plantLabel.text = plant.name
    }
    
}
