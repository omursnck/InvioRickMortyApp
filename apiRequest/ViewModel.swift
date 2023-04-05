//
//  ViewModel.swift
//  apiRequest
//
//  Created by Ömür Şenocak on 5.04.2023.
//

import Foundation

class rmVM: ObservableObject{
    
    @Published var episodeString = "https://rickandmortyapi.com/api/episode/"
    @Published var charactersArray: [Characters.Result] = []
    @Published var updatedCharactersArray: [Characters.Result] = []
    
    @Published var locationArray: [Location.Result] = []
    @Published var updatedLocationArray: [Location.Result] = []
    @Published var episodeArray: [Episode.Result] = []
    @Published var characterEpisodes: [Characters.Result.Episode] = []
    @Published var nextLocationPage: [Location.Info] = []
    @Published var count = 1
    @Published var characterCount = 1
    
    
    
    func getEpisodeData() async{
        print("We are accessing the URL \(episodeString)")
        
        guard let url = URL(string: episodeString) else {
            print("Error: couldnt create a URL from \(episodeString)")
            return
            
        }
        do{
            let(data, _) = try await URLSession.shared.data(from: url)
            
            //Decode
            
            guard let returnedEpisodes = try? JSONDecoder().decode(Episode.self, from: data) else {
                print("Error: couldnt decode ")
                return
                
            }
            DispatchQueue.main.async {
                self.episodeArray = returnedEpisodes.results
            }
        }catch{
            print("Error: couldnt create a URL from \(episodeString)")
            
        }
        
        
    }
    
    func updateLocationData() async{
        
        let locationUrl = "https://rickandmortyapi.com/api/location?page=\(count)"
        print("We are accessing the URL \(locationUrl)")
        
        guard let url = URL(string: locationUrl) else {
            print("Error: couldnt create a URL from \(locationUrl)")
            return
            
        }
        do{
            let(data, _) = try await URLSession.shared.data(from: url)
            
            //Decode
            
            guard let returnedLocations = try? JSONDecoder().decode(Location.self, from: data) else {
                print("Error: couldnt decode ")
                return
                
            }
            DispatchQueue.main.async {
                self.updatedLocationArray = returnedLocations.results
            }
        }catch{
            print("Error: couldnt create a URL from \(locationUrl)")
            
        }
        
        
    }
    
    func getLocationData() async{
        
        let locationUrl = "https://rickandmortyapi.com/api/location?page=1"
        print("We are accessing the URL \(locationUrl)")
        
        guard let url = URL(string: locationUrl) else {
            print("Error: couldnt create a URL from \(locationUrl)")
            return
            
        }
        do{
            let(data, _) = try await URLSession.shared.data(from: url)
            
            //Decode
            
            guard let returnedLocations = try? JSONDecoder().decode(Location.self, from: data) else {
                print("Error: couldnt decode ")
                return
                
            }
            DispatchQueue.main.async {
                self.locationArray = returnedLocations.results
            }
        }catch{
            print("Error: couldnt create a URL from \(locationUrl)")
            
        }
        
        
    }
    
    func updateData() async{
        
        
        let characterUrl = "https://rickandmortyapi.com/api/character/?page=\(characterCount)"
        print("We are accessing the URL \(characterUrl)")
        
        guard let url = URL(string: characterUrl) else {
            print("Error: couldnt create a URL from \(characterUrl)")
            return
            
        }
        do{
            let(data, _) = try await URLSession.shared.data(from: url)
            
            //Decode
            
            guard let returned = try? JSONDecoder().decode(Characters.self, from: data) else {
                print("Error: couldnt decode ")
                return
                
            }
            
            DispatchQueue.main.async {
                self.updatedCharactersArray = returned.results
            }
            
        }catch{
            print("Error: couldnt create a URL from \(characterUrl)")
            
        }
        
        
    }
    
    func getData() async{
        
        
        let characterUrl = "https://rickandmortyapi.com/api/character/?page=1"
        print("We are accessing the URL \(characterUrl)")
        
        guard let url = URL(string: characterUrl) else {
            print("Error: couldnt create a URL from \(characterUrl)")
            return
            
        }
        do{
            let(data, _) = try await URLSession.shared.data(from: url)
            
            //Decode
            
            guard let returned = try? JSONDecoder().decode(Characters.self, from: data) else {
                print("Error: couldnt decode ")
                return
                
            }
            
            DispatchQueue.main.async {
                self.charactersArray = returned.results
            }
            
        }catch{
            print("Error: couldnt create a URL from \(characterUrl)")
            
        }
        
        
    }
}
