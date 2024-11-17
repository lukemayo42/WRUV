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
    //get api-key from plist
    private var apiKey: String {
      get {
        // 1
        guard let filePath = Bundle.main.path(forResource: "spinitron-Info", ofType: "plist") else {
          fatalError("Couldn't find file 'spinitron-Info.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "Apikey") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'spinitron-Info.plist'.")
        }
        return value
      }
    }
    public let dateParser = DateFormatter()
    init(){
        self.dateParser.locale = Locale(identifier: "en_US_POSIX")
        self.dateParser.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    }
    //asynchronus function to get latest spins
    func fetchQuery<T:Decodable>(query: String) async throws -> T{
        let URL = URL(string:"https://spinitron.com/api/\(query)access-token=\(apiKey)")!
        let (data, _) = try await URLSession.shared.data(from: URL)
        return try JSONDecoder().decode(T.self, from: data)
        
    }
    
    //anync function to update structs spins to current
    // called by view to refresh shows
    @MainActor func refreshSpins() async {
        do {
            // Fetch the spins and decode it into a Spins object
            let spinsTemp: Spins = try await fetchQuery(query: "spins?")
            // Assign the items property to self.spins
            
            self.spins = spinsTemp.items
        } catch {
            print("Failed to fetch spins: \(error)")
            self.spins = [] // Set spins to an empty array in case of error
        }
    }
    //this function repeatedly calls a fetch function to refresh in the view
    func startRepeatedFetch(query: @escaping ()async -> Void) {
        Task{
            while true{
                await query()
                print("refresh")
                try? await Task.sleep(nanoseconds: 20 * 1_000_000_000)
            }
        }
    }
    //converts time given by api to human readable time
    func parseTime(time:String)->String{
        let date = dateParser.date(from: time)
                
        //create timePraser to parse the time and date only
        let timeParser = DateFormatter()
        timeParser.dateFormat = "hh:mm a"
                
        let timeString = timeParser.string(from: date!)
        return timeString

    }
    
    func getFirstSpin() -> String{
        return "\(spins[0].song) - \(spins[0].artist)"
        
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








