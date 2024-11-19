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
    @Published var shows: [Show] = []
    @Published var personas: [Persona] = []
    //TODO: create struct to hold corresponding show info and personas to call in view
    
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
    func fetchQuery<T:Decodable>(url: String) async throws -> T{
        let URL = URL(string:url)!
        let (data, _) = try await URLSession.shared.data(from: URL)
        return try JSONDecoder().decode(T.self, from: data)
        
    }
    
    //anync function to update structs spins to current
    // called by view to refresh shows
    @MainActor func refreshSpins() async {
        do {
            // Fetch the spins and decode it into a Spins object
            let spinsTemp: Spins = try await fetchQuery(url: getQueryURL(query:"spins?"))
            // Assign the items property to self.spins
            
            self.spins = spinsTemp.items
        } catch {
            print("Failed to fetch spins: \(error)")
            self.spins = [] // Set spins to an empty array in case of error
        }
    }
    
    @MainActor func refreshShows() async {
        do {
            // Fetch the spins and decode it into a Spins object
            let showsTemp: Shows = try await fetchQuery(url:getQueryURL(query: "shows?"))
            // Assign the items property to self.spins
            
            self.shows = showsTemp.items
            await getPersonas()
        } catch {
            print("Failed to fetch spins: \(error)")
            self.shows = [] // Set spins to an empty array in case of error
        }

    }
    private func getQueryURL(query: String) -> String{
        return "https://spinitron.com/api/\(query)access-token=\(apiKey)"
    }
    private func getPersonas() async{
        var index = 0
        for show in shows{
            do{
                var personasTemp : PersonaResponse = try await fetchQuery(url: show.links!.personas[0].href)
                self.personas[index] = personasTemp.items[0]
                index+=1
            }catch{
                print("Error fetching personas: \(error)")

            }
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



// Persona response
struct PersonaResponse: Decodable {
    let items: [Persona]
}

// Persona (DJ or host)
struct Persona: Decodable {
    let id: Int
    let name: String
    let bio: String
    let since: Int
    let email: String
    let website: String
    let image: String
    
}




// Show response
struct Shows: Decodable {
    let items: [Show]

}

// Show item
struct Show: Decodable {
    let id: Int?
    let start: String?
    let end: String?
    let title: String?
    let links: ShowLinks?
    
    enum CodingKeys: String, CodingKey {
        case id, start, end, title
        case links = "_links"
    }
}

// Show links for related resources
struct ShowLinks: Decodable {
    let personas: [Link]
    
}

// Common Link struct for various relations (like personas, playlists)
struct Link: Decodable {
    let href: String
}


// Links struct for self-referencing links
struct Links: Decodable {
    let selfLink: Link
    
    enum CodingKeys: String, CodingKey {
        case selfLink = "self"
    }
}









