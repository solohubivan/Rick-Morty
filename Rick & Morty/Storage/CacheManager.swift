//
//  CacheManager.swift
//  Rick & Morty
//
//  Created by Ivan Solohub on 13.02.2025.
//

import CoreData
import Alamofire
import UIKit

class CacheManager {
    static let shared = CacheManager()
    
    private let context = CoreDataStack.shared.context
    
    func saveAllToCache(_ characters: [CharacterModel]) {
        let existingIDs = getCachedCharacterIDs()
        
        let dispatchGroup = DispatchGroup()
        
        for character in characters {
            guard !existingIDs.contains(character.id) else { continue }
            
            dispatchGroup.enter()
            
            loadImage(from: character.image) { imageData in
                let cachedCharacter = CachedCharacter(context: self.context)
                cachedCharacter.id = Int64(character.id)
                cachedCharacter.name = character.name
                cachedCharacter.status = character.status
                cachedCharacter.species = character.species
                cachedCharacter.gender = character.gender
                cachedCharacter.origin = character.origin.name
                cachedCharacter.location = character.location.name
                cachedCharacter.episodeCount = Int64(character.episode.count)
                cachedCharacter.imageData = imageData
                
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.saveContext()
        }
    }
    
    func loadAllFromCache() -> [CharacterModel] {
        let fetchRequest: NSFetchRequest<CachedCharacter> = CachedCharacter.fetchRequest()
        
        do {
            let cachedCharacters = try context.fetch(fetchRequest)
            return cachedCharacters.map { cachedCharacter in
                CharacterModel(
                    id: Int(cachedCharacter.id),
                    name: cachedCharacter.name ?? "Unknown",
                    status: cachedCharacter.status ?? "Unknown",
                    species: cachedCharacter.species ?? "Unknown",
                    gender: cachedCharacter.gender ?? "Unknown",
                    image: "",
                    origin: Origin(name: cachedCharacter.origin ?? "Unknown"),
                    location: Location(name: cachedCharacter.location ?? "Unknown"),
                    episode: Array(repeating: "", count: Int(cachedCharacter.episodeCount)),
                    imagePicture: cachedCharacter.imageData
                )
            }
        } catch {
            print("Error fetching cached data: \(error.localizedDescription)")
            return []
        }
    }
    
    private func getCachedCharacterIDs() -> Set<Int> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CachedCharacter.fetchRequest()
        fetchRequest.resultType = .dictionaryResultType
        fetchRequest.propertiesToFetch = ["id"]

        do {
            let results = try context.fetch(fetchRequest) as? [[String: Any]]
            return Set(results?.compactMap { dict in
                if let id = dict["id"] as? Int64 {
                    return Int(id)
                }
                return nil
            } ?? [])
        } catch {
            print("Error fetching character IDs: \(error.localizedDescription)")
            return []
        }
    }
    
    func clearCache() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CachedCharacter.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            saveContext()
        } catch {
            print("Error clearing cache: \(error.localizedDescription)")
        }
    }
    
    private func loadImage(from urlString: String, completion: @escaping (Data?) -> Void) {
        AF.request(urlString).responseData { response in
            switch response.result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print("Error loading image: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error.localizedDescription)")
        }
    }
}
