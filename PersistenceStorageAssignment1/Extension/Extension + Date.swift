//
//  Extension + Date.swift
//  PersistenceStorageAssignment1
//
//  Created by Macmini-13 on 21/09/2022.
//

import Foundation

//MARKS:- Extension
extension Date {
    
    func dateToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
       return formatter.string(from: self)
    }
}
