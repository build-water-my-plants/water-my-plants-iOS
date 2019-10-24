//
//  PlantDetailViewController.swift
//  ios-WaterMyPlants
//
//  Created by Michael Flowers on 10/23/19.
//  Copyright © 2019 LambdaSchool. All rights reserved.
//

import UIKit

class PlantDetailViewController: UIViewController {
    var plant: Plant? {
            didSet {
                updateViews()
            }
        }
        var user: User? {
            didSet {
                updateViews()
            }
        }
        
        var imagePicker = UIImagePickerController()
        
        @IBOutlet weak var plantImageView: UIImageView!
        @IBOutlet weak var plantNameTextField: UITextField!
        @IBOutlet weak var datePickerProperties: UIDatePicker!
        @IBOutlet weak var speciesTextField: UITextField!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            updateViews()
            imagePicker.delegate = self
        }
        
        func repeatSchedule(day: Int, hour: Int, min: Int ){
           
        }
        
        @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
            guard let image = plantImageView.image, let name = plantNameTextField.text, !name.isEmpty, let speciesName = speciesTextField.text, !speciesName.isEmpty else { return }
            let data = image.jpegData(compressionQuality: 0.5)
          
            if let passedInPlant = plant {
                //UPDATE PLANT
                 print(" this is the date string format: \(datePickerProperties.date.formatDate())")
                PlantController.update(plant: passedInPlant, withNewName: name, withNewSpecies: speciesName, withNewSchedule: datePickerProperties.date, withNewPhoto: data)
            }  else  {
                //CREATE NEW PLANT
    //            guard let passedInOwner = owner else { return }
                let user = User(username: "testOwner1", phoneNumber: "owner1@email.com", password: "password")
                print(" this is the date string format: \(datePickerProperties.date.formatDate())")
                PlantController.createPlantWith(name: name, species: speciesName, photo: data, schedule: datePickerProperties.date, user: user)
            }
            navigationController?.popToRootViewController(animated: true)
        }
        
        @IBAction func cameraButtonTapped(_ sender: UIBarButtonItem) {
            //SHOW ACTION SHEET WI/OPTION TO CHOOSE LIBRARY OR CAMERA
            actionSheet()
        }
        
        @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
            //???
        }
        
        private func updateViews(){
            guard let passedInPlant = plant, let photoData = passedInPlant.photo, let photoImage = UIImage(data: photoData), let date = passedInPlant.schedule, isViewLoaded else {
                title = "Please create plant"
                return }
            plantImageView.image = photoImage
            plantNameTextField.text = passedInPlant.name
            datePickerProperties.date = date
        }

        func showCamera(){
            //check to see if they have camera
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                //dress up camera
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = false
                //present the imagepicker
                present(imagePicker, animated: true)
            } else {
                //show library
            }
        }
        
        func showLibrary(){
            //check to see if library is available
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = false
                present(imagePicker, animated: true)
            }
        }
        
        func actionSheet(){
            let alert = UIAlertController(title: "Chose Camera or Photo Library", message: nil, preferredStyle: .actionSheet)
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
                self.showCamera()
            }
            
            let libraryAction = UIAlertAction(title: "Photo Library", style: .default) { (_) in
                self.showLibrary()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            alert.addAction(cameraAction)
            alert.addAction(libraryAction)
            alert.addAction(cancelAction)
            present(alert, animated: true)
        }
    }

    extension PlantDetailViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else { return }
            self.plantImageView.image = image
            
            dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true)
        }
    }

