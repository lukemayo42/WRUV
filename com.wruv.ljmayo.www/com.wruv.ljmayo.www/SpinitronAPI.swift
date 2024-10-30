//
//  SpinitronAPI.swift
//  com.wruv.ljmayo.www
//
//  Created by user268773 on 10/29/24.
//

import Foundation


struct SpinWrapper:Codable{
    var items : [Spin]
    
}

struct ShowWrapper: Codable{
    var items: [Show]
}

struct Spin: Codable{
    let image : String
    let artist : String
    let release : String
    let label: String
    let genre: String
    let released: Int
    let song: String
    
}

struct Show: Codable{
    let start:String
    let end: String
    let title: String
}
