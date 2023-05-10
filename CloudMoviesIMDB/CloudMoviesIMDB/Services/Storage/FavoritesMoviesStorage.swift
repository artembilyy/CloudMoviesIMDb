//
//  FavoritesMoviesStorage.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 09.05.2023.
//

import CoreData
import UIKit

protocol FavoritesMoviesStorageProtocol {
    func saveMovie(_ movie: Movies.Movie)
    func deleteMovie(_ movie: Movies.Movie)
    func checkIsFavorite(movie: Movies.Movie) -> Bool
}
final class FavoritesMoviesStorage: FavoritesMoviesStorageProtocol {
    static let shared = FavoritesMoviesStorage()
    
    private init() { }
    
    private let container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    private lazy var managedObjectContext: NSManagedObjectContext? = container?.viewContext
    
    func saveMovie(_ movie: Movies.Movie) {
        let fetchRequest = NSFetchRequest<FavoritesMovies>(entityName: "FavoritesMovies")
        fetchRequest.predicate = NSPredicate(format: "title == %@", movie.title ?? "")
        do {
            let movies = try managedObjectContext?.fetch(fetchRequest)
            if let existingMovie = movies?.first {
                print("Movie with title '\(existingMovie.title ?? "")' already exists, skipping save.")
                return
            }
        } catch let error {
            print("Failed to fetch movies: \(error)")
        }
        guard let managedObjectContext else { return }
        guard let entity = NSEntityDescription.entity(forEntityName: "FavoritesMovies", in: managedObjectContext) else {
            fatalError("Failed to get entity description for MovieEntity")
        }
        let movieObject = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        movieObject.setValue(movie.title, forKey: "title")
        do {
            try managedObjectContext.save()
            print("Movie saved to CoreData")
        } catch let error {
            print("Failed to save movie: \(error)")
        }
    }
    func deleteMovie(_ movie: Movies.Movie) {
        let fetchRequest = NSFetchRequest<FavoritesMovies>(entityName: "FavoritesMovies")
        fetchRequest.predicate = NSPredicate(format: "title == %@", movie.title ?? "")
        do {
            guard let managedObjectContext else { return }
            let movies = try managedObjectContext.fetch(fetchRequest)
            guard let movieObject = movies.first else {
                print("Movie with title '\(movie.title ?? "")' does not exist in CoreData, skipping delete.")
                return
            }
            managedObjectContext.delete(movieObject)
            try managedObjectContext.save()
            print("Movie deleted from CoreData")
        } catch let error {
            print("Failed to delete movie: \(error)")
        }
    }
    func deleteAllMovies() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritesMovies")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            guard let managedObjectContext else { return }
            try managedObjectContext.execute(batchDeleteRequest)
            print("All movies deleted from CoreData")
        } catch let error {
            print("Failed to delete all movies: \(error)")
        }
    }
    func checkIsFavorite(movie: Movies.Movie) -> Bool {
        let fetchRequest = NSFetchRequest<FavoritesMovies>(entityName: "FavoritesMovies")
        do {
            guard let managedObjectContext else { return false }
            let savedMovies = try managedObjectContext.fetch(fetchRequest)
            for savedMovie in savedMovies where savedMovie.title == movie.title {
                return true
            }
        } catch let error {
            print("Failed to fetch movies: \(error)")
        }
        return false
    }
}
