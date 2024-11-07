import UIKit

//
//  SpinitronAPI.swift
//  com.wruv.ljmayo.www
//
//  Created by user268773 on 10/29/24.
//

import Foundation

class SpinitronValues:ObservableObject{
    // variables to hold data
    @Published var spins: [Spin] = []
    
    //asynchronus function to get latest spins
    //TODO: turn into generic function
    func fetchSpins() async throws -> [Spin]{
        let URL = URL(string:"https://spinitron.com/api/spins?access-token=xGRYmmG0rqj26gUzztBqVpjj")!
        let (data, _) = try await URLSession.shared.data(from: URL)
        let spins = try JSONDecoder().decode(Spins.self, from: data)
        return spins.items
    }
    
    //anync function to update structs spins to current
    // called by view to refrs
    func refreshSpins() async {
        self.spins = (try? await fetchSpins()) ?? [] }
    
    //fetches image based on url
    func fetchImage(url: String?) async throws -> Data?{
        if url == nil{
            return nil
        }
        let imageURL = URL(string: url!)
        let (data, _) = try await URLSession.shared.data(from: imageURL!)
        return data
    }
    
}

struct Spins:Decodable{
    var items : [Spin]
    
}

struct Shows: Decodable{
    var items: [Show]
}

struct Spin: Decodable{
    let id = UUID()
    let image : String?
    let artist : String
    let release : String?
    let label: String?
    let genre: String?
    let released: Int?
    let song: String
    let time: String
    let date: String
    
    enum CodingKeys: String, CodingKey{
        case image
        case artist
        case release
        case label
        case genre
        case released
        case song
        case time = "start"
        case date = "end"
    }
    
}

struct link: Decodable{
    let personas: personasLink
}

struct personasLink: Decodable{
    let link: String
    
    enum CodingKeys: String, CodingKey{
        case link = "href"
    }
}

struct Show: Decodable{
    let start:String
    let end: String
    let title: String
}

func fetchSpins() async throws -> [Spin]{
    let spinsURL = URL(string:"https://spinitron.com/api/spins?access-token=api-key")!
    let (data, _) = try await URLSession.shared.data(from: spinsURL)
    let spins = try JSONDecoder().decode(Spins.self, from: data)
    return spins.items
}






