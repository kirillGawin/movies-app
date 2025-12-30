//
//  FavouritesService.swift
//  MoviesApp
//
//  Created by gawin on 30/12/2025.
//

import CoreData

final class FavouritesService {
    
    private let context = CoreDataStack.shared.context
    
    func isFavourite(id: Int) -> Bool {
        let request: NSFetchRequest<FavouriteMovie> = FavouriteMovie.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        return (try? context.count(for: request)) ?? 0 > 0
    }
    
    func add(movie: MovieDTO) {
        guard !isFavourite(id: movie.id) else { return }
        
        let fav = FavouriteMovie(context: context)
        fav.id = Int64(movie.id)
        fav.title = movie.title
        fav.overview = movie.overview
        fav.posterPath = movie.posterPath
        
        CoreDataStack.shared.save()
    }
    
    func remove (id: Int) {
        let request: NSFetchRequest<FavouriteMovie> = FavouriteMovie.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        if let object = try? context.fetch(request).first {
            context.delete(object)
            CoreDataStack.shared.save()
        }
    }
    
    func fetchAll() -> [FavouriteMovie] {
        let request: NSFetchRequest<FavouriteMovie> = FavouriteMovie.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
  
          
}
