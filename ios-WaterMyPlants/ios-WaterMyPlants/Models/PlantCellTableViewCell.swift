//
//  PlantCellTableViewCell.swift
//  ios-WaterMyPlants
//
//  Created by Michael Flowers on 10/23/19.
//  Copyright © 2019 LambdaSchool. All rights reserved.
//

import UIKit

class PlantCellTableViewCell: UITableViewCell {

    //MARK: - Properties
    var plant: Plant? {
          didSet {
              updateVeiws()
          }
      }
      
    //MARK: - IBOutlets
      @IBOutlet weak var plantImageView: UIImageView!
      @IBOutlet weak var plantScheduleLabel: UILabel!
      @IBOutlet weak var plantNameLabel: UILabel!
      
    //MARK: - Private Functions
      private func updateVeiws(){
          guard let passedInPlant = plant,
              let photoData = passedInPlant.photo,
              let image = UIImage(data: photoData)
              else {
               print("Error passing plant into tableViewCell")
              return }
          
              plantScheduleLabel.text = passedInPlant.schedule?.formatDate()
          print(passedInPlant.schedule?.formatDate())
              plantNameLabel.text = passedInPlant.name
          plantImageView.image = image
      }

}
