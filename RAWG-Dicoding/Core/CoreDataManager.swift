//
//  CoreDataManager.swift
//  RAWG-Dicoding
//
//  Created by Finn Christoffer Kurniawan on 14/03/23.
//

import UIKit
import CoreData

final class FavoriteCoreDataManager {
    // MARK: - Shared
    static let shared = FavoriteCoreDataManager()
    private let managedContext: NSManagedObjectContext!
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Favorite
    func saveFavorite(gameId: Int, imageId: String) -> Bool? {
        let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: managedContext)!
        let game = NSManagedObject(entity: entity, insertInto: managedContext)
        game.setValue(gameId, forKey: "gameId")
        game.setValue(imageId, forKey: "imageId")
        
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            NotificationCenter.default.post(name: NSNotification.Name("detailGamesErrorMessage"), object: error.localizedDescription)
            return nil
        }
    }
    
    func getFavorites() -> [Favorite] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        do {
            let games = try managedContext.fetch(fetchRequest)
            return games as! [Favorite]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            NotificationCenter.default.post(name: NSNotification.Name("favoriteGamesErrorMessage"), object: error.localizedDescription)
        }
        return []
    }
    
    func deleteFavorite(game: Favorite) {
        managedContext.delete(game)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            NotificationCenter.default.post(name: NSNotification.Name("favoriteGamesErrorMessage"), object: error.localizedDescription)
        }
    }
    
    func editFavorite(obj: Favorite, imageId: String) {
        let game = managedContext.object(with: obj.objectID)
        game.setValue(imageId, forKey: "imageId")
        do {
            try managedContext.save()
        } catch let error as NSError {
            NotificationCenter.default.post(name: NSNotification.Name("favoriteGamesErrorMessage"), object: error.localizedDescription)
        }
    }
    
    func isFavorite(_ id: Int) -> Bool? {
        let fetchRequest: NSFetchRequest<Favorite>
        fetchRequest = Favorite.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "gameId = %d", id)
        do {
            let objects = try managedContext.fetch(fetchRequest)
            if objects.count > 0 {
                return true
            }
            return false
        } catch let error as NSError {
            NotificationCenter.default.post(name: NSNotification.Name("detailGamesErrorMessage"), object: error.localizedDescription)
            return nil
        }
    }
    
    func deleteFavoriteWithId(id:Int) -> Bool?{
        let fetchRequest: NSFetchRequest<Favorite>
        fetchRequest = Favorite.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(
            format: "gameId = %d", id)
        do {
            let objects = try managedContext.fetch(fetchRequest)
            for game in objects{
                deleteFavorite(game: game)
            }
            return false
        } catch let error as NSError {
            NotificationCenter.default.post(name: NSNotification.Name("detailGamesErrorMessage"), object: error.localizedDescription)
            return nil
        }
    }
}
