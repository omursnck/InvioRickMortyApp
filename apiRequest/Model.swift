//
//  Model.swift
//  apiRequest
//
//  Created by Ömür Şenocak on 7.03.2023.
//

import Foundation



struct Characters: Codable{
    let info : Info
    let results : [Result]
    
    struct Info : Codable{
        let count: Int
        let pages: Int
        let next: String
        let prev: String?
    }
    
    struct Result: Codable, Hashable{
        
        let id: Int
        let name: String
        let status: String
        let species: String
        let type: String
        let gender: String
        let image: String
        let episode: [String]
        let url :String
        let created : String
        let origin, location : Location
        
        struct Location : Codable, Hashable{
            let name: String
            let url: String
            
            
        }
        struct Episode : Codable, Hashable{
            let name: String
            let url: String
            
            
        }
    }
}

struct Episode: Codable {
    var info: Info
    var results: [Result]
    
    struct Info: Codable {
        var count, pages: Int
        var next: String
        var prev: String?
    }
    
    struct Result: Codable {
        var id: Int
        var name, airDate, episode: String
        var characters: [String]
        var url: String
        var created: String
        
        enum CodingKeys: String, CodingKey {
            case id, name
            case airDate = "air_date"
            case episode, characters, url, created
        }
    }
}







struct Location : Codable{
    let info : Info
    let results : [Result]
    
    
    struct Info : Codable{
        let count: Int
        let pages: Int
        let next: String
        let prev: String?
    }
    
    struct Result: Codable,Hashable{
        
        let id: Int
        let name: String
        let type: String
        let url :String
        let created : String
        // let residents : Characters
        
        
        
    }
    
    
}
