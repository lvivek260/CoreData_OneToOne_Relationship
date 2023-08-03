//
//  UIViewController+Extension.swift
//  CoreData_OneToOne
//
//  Created by PHN MAC 1 on 31/07/23.
//

import UIKit

extension UIViewController{
    var id: String {
        return String(describing: self)
    }
    
    func showAlert(message: String){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "Okey", style: .cancel)
        alert.addAction(okBtn)
        self.present(alert, animated: true)
    }
}
