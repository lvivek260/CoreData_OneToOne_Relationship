//
//  CoreDataHelper.swift
//  CoreData_OneToOne
//
//  Created by PHN MAC 1 on 31/07/23.
//

import UIKit
import CoreData

final class CoreDataManager{
    //Created Singleton Class
    static let shared: CoreDataManager = CoreDataManager()
    private init(){}
    
    var context: NSManagedObjectContext{
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
// MARK: - Crud Operations
    func savePersonData(person: PersonModel){
        let mobileEntity = MobileEntity(context: context)
        mobileEntity.companyName = person.mobile.companyName
        mobileEntity.ram = person.mobile.ram
        mobileEntity.rom = person.mobile.rom
        mobileEntity.processor = person.mobile.processor
        
        let personEntity = PersonEntity(context: context)
        personEntity.firstName = person.firstName
        personEntity.lastName = person.lastName
        personEntity.age = person.age
        
        personEntity.mobile = mobileEntity
        mobileEntity.person = personEntity
        
        saveContext()
    }
    
    func fetchPerson()-> [PersonEntity]{
        var persons = [PersonEntity]()
        do{
            try persons = context.fetch(.init(entityName: "PersonEntity"))
        }
        catch let error{
            print("Person Data Fetching Error", error)
        }
        return persons
    }
    
    func updatePerson(personEntity: PersonEntity, person: PersonModel){
        personEntity.firstName = person.firstName
        personEntity.lastName = person.lastName
        personEntity.age = person.age
        personEntity.mobile?.companyName = person.mobile.companyName
        personEntity.mobile?.processor = person.mobile.processor
        personEntity.mobile?.ram = person.mobile.ram
        personEntity.mobile?.rom = person.mobile.rom
        saveContext()
    }
    
    func deletePerson(personEntity: PersonEntity){
        context.delete(personEntity)
        guard let mobileEntity = personEntity.mobile else {return}
        context.delete(mobileEntity)
        saveContext()
    }
    
    
// MARK: - Common Methods
    func saveContext(){
        do{
            try context.save()
        }
        catch let err{
            print("Context Saving Error:- ",err)
        }
    }
}
