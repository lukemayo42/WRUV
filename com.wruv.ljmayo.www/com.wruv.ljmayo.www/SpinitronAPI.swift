//
//  SpinitronAPI.swift
//  com.wruv.ljmayo.www
//
//  Created by user268773 on 10/29/24.
//

import Foundation


struct Spins:Decodable{
    var items : [Spin]
    
}

struct Shows: Decodable{
    var items: [Show]
}

struct Spin: Decodable{
    let image : String
    let artist : String
    let release : String
    let label: String
    let genre: String
    let released: Int
    let song: String
    let links: link
    
    enum CodingKeys: String, CodingKey{
        case image
        case artist
        case release
        case label
        case genre
        case relaesed
        case song
        case links = "_links"
    }
}

struct link: Decodable{
    let personas: personasLink
}

struct personasLink: Decodable{
    let link: String
    
    enum CodingKeys: String, CodingKey{
        link = "href"
    }
}

struct Show: Decodable{
    let start:String
    let end: String
    let title: String
}

func fetchSpins() async throws -> Spins{
    let spinsURL = URL(string:"https://spinitron.com/api/spins?access-token=api-key")
    let (data, _) = try await URLSession.shared.data(from: spinsURL)
    let spins = try JSONDecoder().decode(Wrapper.self, from: data)
    return spins
}
Task{
    try await fetchSpins()
}


