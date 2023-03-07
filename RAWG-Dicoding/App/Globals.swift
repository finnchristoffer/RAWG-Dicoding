//
//  Globals.swift
//  RAWG-Dicoding
//
//  Created by Finn Christoffer Kurniawan on 07/03/23.
//

import Foundation

final class Globals {
    static let sharedInstance = Globals()
    private init(){}
    
    //MARK: - Settings
    var isLocalColorCalculationEnabled = true
    #warning("Experimental feature enabled")
    //Experimental
    //Have performance Impact
    //Does not have dark/light awarness
    //can be hard to read
    
    //MARK: - States
    
    var isFirstLaunch = true
    
    var isFavoriteChanged = false
    
    var isNotesChanged = false
    
    //MARK: - Helpers
    func formatDate(date:String) -> String{
        return date.replacingOccurrences(of: "-", with: "/")
    }
    
    func backlinkHelper(id:Int?) -> String{
        if let id{
            return "https://rawg.io/games/\(id)"
        }
        return "https://rawg.io/games/"
    }
    
    func resizeImageRemote(imgUrl:String?, size:Int = 640) -> String?{
        return imgUrl?.replacingOccurrences(of: "media/g", with: "media/resize/\(size)/-/g")
    }
    
    func Esrb (id:Int?) -> String{
        if let ratingId = id {
            switch ratingId {
            case 1:
                return "E"
            case 2:
                return "E10+"
            case 3:
                return "T"
            case 4:
                return "M"
            case 5:
                return "AO"
            case 6:
                return "RP"
            default:
                return "NR"
            }
        }
        return "NR"
    }
    
}
