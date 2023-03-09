//
//  ProfileModel.swift
//  RAWG-Dicoding
//
//  Created by Finn Christoffer Kurniawan on 06/03/23.
//

import Foundation

struct ProfileModel {
    static let nameKey = "name"
    static let aboutKey = "about"
    static let emailKey = "email"
    static let imageKey = "image"

    static var image: Data {
        get {
            return UserDefaults.standard.data(forKey: imageKey) ?? Data()
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: imageKey)
        }
    }

    static var name: String {
        get {
            return UserDefaults.standard.string(forKey: nameKey) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: nameKey)
        }
    }

    static var about: String {
        get {
            return UserDefaults.standard.string(forKey: aboutKey) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: aboutKey)
        }
    }
    
    static var email: String {
        get {
            return UserDefaults.standard.string(forKey: emailKey) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: emailKey)
        }
    }

//    static func deteleAll() -> Bool {
//        if let domain = Bundle.main.bundleIdentifier {
//            UserDefaults.standard.removePersistentDomain(forName: domain)
//            synchronize()
//            return true
//        } else { return false }
//    }

    static func synchronize() {
        UserDefaults.standard.synchronize()
    }
}
