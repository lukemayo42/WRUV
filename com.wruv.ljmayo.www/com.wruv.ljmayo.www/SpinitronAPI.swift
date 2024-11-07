import UIKit

//
//  SpinitronAPI.swift
//  com.wruv.ljmayo.www
//
//  Created by user268773 on 10/29/24.
//

import Foundation

class SpinitronValues{
    // variables to hold data
    var spins: [Spin]
    init(){
        spins = []
    }
        
    func fetchSpins(field:String, parameters:String) async throws -> [Spin]{
        let URL = URL(string:"https://spinitron.com/api/spins?access-token=api-key")!
        let (data, _) = try await URLSession.shared.data(from: URL)
        let spins = try JSONDecoder().decode(Spins.self, from: data)
        return spins.items
    }

}
struct Spins:Decodable{
    var items : [Spin]
    
}

struct Shows: Decodable{
    var items: [Show]
}

struct Spin: Decodable{
    let image : String?
    let artist : String
    let release : String?
    let label: String?
    let genre: String?
    let released: Int?
    let song: String

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






