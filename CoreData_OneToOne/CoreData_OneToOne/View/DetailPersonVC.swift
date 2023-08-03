//
//  DetailPersonVC.swift
//  CoreData_OneToOne
//
//  Created by PHN MAC 1 on 31/07/23.
//

import UIKit

class DetailPersonVC: UIViewController {
// MARK: - IBOutlets
    //Person Outlets
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    //Mobile Outlets
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblProcessor: UILabel!
    @IBOutlet weak var lblRam: UILabel!
    @IBOutlet weak var lblRom: UILabel!
    //Other Variables, Objects
    var personEntity: PersonEntity?
    
// MARK: - ViewLifeCycles
    override func viewWillAppear(_ animated: Bool) {
        setData()
    }
    
// MARK: - IBActions
    @IBAction func editBtnClick(_ sender: Any) {
        guard let updateVC = storyboard?.instantiateViewController(withIdentifier: "AddUpdatePersonVC") as? AddUpdatePersonVC else {
            return
        }
        updateVC.personEntity = personEntity
        updateVC.isUpdate = true
        navigationController?.pushViewController(updateVC, animated: true)
    }
}

// MARK: - Methods
extension DetailPersonVC{
    private func setData(){
        //set person data here
        guard let personEntity else {return}
        lblFirstName.text = personEntity.firstName ?? ""
        lblLastName.text = personEntity.lastName ?? ""
        lblAge.text = String(personEntity.age)
        
        //set mobile data here
        guard let mobile = personEntity.mobile else {return}
        lblCompanyName.text = mobile.companyName ?? ""
        lblProcessor.text = mobile.processor ?? ""
        lblRam.text = String(mobile.ram)
        lblRom.text = String(mobile.rom)
    }
}
