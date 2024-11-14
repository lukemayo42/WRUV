import UIKit

//
//  SpinitronAPI.swift
//  com.wruv.ljmayo.www
//
//  Created by user268773 on 10/29/24.
//

import Foundation

@MainActor class SpinitronValues:ObservableObject{
    // variables to hold data
    @Published var spins: [Spin] = []
    
    //asynchronus function to get latest spins
    //TODO: turn into generic function
    func fetchSpins<T:Decodable>(query: String) async throws -> T{
        let URL = URL(string:"https://spinitron.com/api/\(query)access-token=token")!
        let (data, _) = try await URLSession.shared.data(from: URL)
        return try JSONDecoder().decode(T.self, from: data)
        
    }
    
    //anync function to update structs spins to current
    // called by view to refrs
    @MainActor func refreshSpins() async {
        do {
            // Fetch the spins and decode it into a Spins object
            let spinsTemp: Spins = try await fetchSpins(query: "spins?") // Ensure it's a Spins object
            // Assign the items property to self.spins
            self.spins = spinsTemp.items
        } catch {
            print("Failed to fetch spins: \(error)")
            self.spins = [] // Set spins to an empty array in case of error
        }
    }
    
    @MainActor func refreshShows() async {
        
    }
    
    
    
        
    
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
    //let date: String
    
    enum CodingKeys: String, CodingKey{
        case image
        case artist
        case release
        case label
        case genre
        case released
        case song
        case time = "start"
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

struct Shows: Decodable{
    var items: [Show]
}

struct Show: Decodable{
    let start:String
    let end: String
    let title: String
}








