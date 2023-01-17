//
//  Session.swift
//  Prueba
//
//  Created by Pepe Ruiz on 17/01/23.
//

import Foundation

struct Session {
    private static let userDefault = UserDefaults.standard
    
    static var busqueda: [String] {
        get {
            if let data = userDefault.data(forKey: "querys") {
                let q = try! JSONDecoder().decode([String].self, from: data)
                return q
            }
            return [String]()
        }
        
        set {
            let q = try! JSONEncoder().encode(newValue)
            userDefault.set(q, forKey: "querys")
        }
    }
}
