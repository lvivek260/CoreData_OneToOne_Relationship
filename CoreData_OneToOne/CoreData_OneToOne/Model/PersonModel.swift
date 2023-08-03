//
//  PersonModel.swift
//  CoreData_OneToOne
//
//  Created by PHN MAC 1 on 31/07/23.
//

import Foundation

struct PersonModel{
    let firstName: String
    let lastName: String
    let age: Int16
    let mobile: MobileModel
}

struct MobileModel{
    let companyName: String
    let ram: Int16
    let rom: Int16
    let processor: String
}
