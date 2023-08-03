//
//  AddUpdatePersonVC.swift
//  CoreData_OneToOne
//
//  Created by PHN MAC 1 on 31/07/23.
//

import UIKit

class AddUpdatePersonVC: UIViewController {
// MARK: - IBOutlets
    //person Outlets
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    //mobile Outlets
    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var txtProcessor: UITextField!
    @IBOutlet weak var txtRam: UITextField!
    @IBOutlet weak var txtRom: UITextField!
    //variables
    var personEntity: PersonEntity?
    var isUpdate: Bool = false
    
// MARK: - ViewLifeCycles
    override func viewWillAppear(_ animated: Bool) {
        uiConfiguration()
    }
    
// MARK: - IBActions
    @IBAction func saveBtnClick(_ sender: Any) {
        //check validation first
        let validation = checkValidation()
        if !validation.0{return}
        guard let person = validation.1 else {return}
        
        if isUpdate{//Update data here
            guard let personEntity else {return}
            CoreDataManager.shared.updatePerson(personEntity: personEntity, person: person)
        }
        else{ // New data add here
            CoreDataManager.shared.savePersonData(person: person)
        }
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Methods
extension AddUpdatePersonVC{
    private func uiConfiguration(){
        if isUpdate{//Update data here
            title = "Update Person"
            guard let personEntity else {return}
            txtFirstName.text = personEntity.firstName ?? ""
            txtLastName.text = personEntity.lastName ?? ""
            txtAge.text = String(personEntity.age)
            guard let mobile = personEntity.mobile else {return}
            txtCompanyName.text = mobile.companyName ?? ""
            txtProcessor.text = mobile.processor ?? ""
            txtRam.text = String(mobile.ram)
            txtRom.text = String(mobile.rom)
        }
        else{ // New data add here
            title = "Add Person"
        }
    }
    
    private func checkValidation()->(Bool, PersonModel?){
        //Check textfield Empty or Not
        guard let firstName = txtFirstName.text, firstName != "" else {
            showAlert(message: "First name should not be empty")
            return (false, nil)
        }
        guard let lastName = txtLastName.text, lastName != "" else {
            showAlert(message: "Last name should not be empty")
            return (false, nil)
        }
        guard let age = txtAge.text, age != "" else {
            showAlert(message: "Age should not be empty")
            return (false, nil)
        }
        guard let mobileCompany = txtCompanyName.text, mobileCompany != "" else {
            showAlert(message: "Mobile Company name should not be empty")
            return (false, nil)
        }
        guard let processor = txtProcessor.text, processor != "" else {
            showAlert(message: "Processor name should not be empty")
            return (false, nil)
        }
        guard let ram = txtRam.text, ram != "" else {
            showAlert(message: "Ram should not be empty")
            return (false, nil)
        }
        guard let rom = txtRom.text, rom != "" else {
            showAlert(message: "Rom should not be empty")
            return (false, nil)
        }
        //convert string to Interger
        guard let age = Int16(age) else {
            showAlert(message: "Please Check Age")
            return (false, nil)
        }
        guard let ram = Int16(ram) else {
            showAlert(message: "Please Check Ram")
            return (false, nil)
        }
        guard let rom = Int16(rom) else {
            showAlert(message: "Please Check Rom")
            return (false, nil)
        }
        let mobile = MobileModel(companyName: mobileCompany, ram: ram, rom: rom, processor: processor)
        let person = PersonModel(firstName: firstName, lastName: lastName, age: age, mobile: mobile)
        return (true, person)
    }
}
