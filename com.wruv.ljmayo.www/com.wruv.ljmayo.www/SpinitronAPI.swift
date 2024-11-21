import UIKit

//
//  SpinitronAPI.swift
//  com.wruv.ljmayo.www
//
//  Created by user268773 on 10/29/24.
//

import Foundation

//@MainActor class SpinitronValues:ObservableObject{
//    // variables to hold data
//    @Published var spins: [Spin] = []
//    var isFetching = false
//    @Published var shows: ShowModel = ShowModel()
//    @Published var currShow: ShowValues = ShowValues(showName: "placeholder", djName: "placeholder", start: "placeholer")
//    
//    //get api-key from plist
//    private var apiKey: String {
//      get {
//        // 1
//        guard let filePath = Bundle.main.path(forResource: "spinitron-info", ofType: "plist") else {
//          fatalError("Couldn't find file 'spinitron-Info.plist'.")
//        }
//        // 2
//        let plist = NSDictionary(contentsOfFile: filePath)
//        guard let value = plist?.object(forKey: "api-key") as? String else {
//          fatalError("Couldn't find key 'API_KEY' in 'spinitron-Info.plist'.")
//        }
//        return value
//      }
//    }
//    public let dateParser = DateFormatter()
//    
//    init(){
//        self.dateParser.locale = Locale(identifier: "en_US_POSIX")
//        self.dateParser.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
//    }
//    
//    //generic T represents structs that decode the JSON returned by the url given as a parameter
//    func fetchQuery<T:Decodable>(url: String) async throws -> T{
//        let URL = URL(string:url)!
//        let (data, _) = try await URLSession.shared.data(from: URL)
//        return try JSONDecoder().decode(T.self, from: data)
//        
//    }
//    
//    // this function refreshed the spins
//    @MainActor func refreshSpins() async {
//        guard !isFetching else { return }
//        
//        isFetching = true
//        do {
//
//            // Fetch the spins and decode it into a Spins object
//            let spinsTemp: Spins = try await fetchQuery(url: getQueryURL(query:"spins?"))
//            // Assign the items property to self.spins
//            
//            self.spins = spinsTemp.items
//        } catch {
//            print("Failed to fetch spins: \(error)")
//            self.spins = [] // Set spins to an empty array in case of error
//        }
//        
//        isFetching = false
//    }
//    
//    //calls the api to refresh the shows and associated personas with the shows
//    @MainActor func refreshShows() async {
//        guard !isFetching else { return }
//        isFetching = true
//        var showModelTemp : [ShowValues] = []
//        do {
//            //format the date so that it can be included in the api query
//            // only get the shows in the next 24 hours to diplay
//            let currentDate = Date()
//            let calendar = Calendar.current
//            let nextDay = calendar.date(byAdding: .day, value: 1, to: currentDate)
//            let dateFormatterTemp = DateFormatter()
//            dateFormatterTemp.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//            dateFormatterTemp.timeZone = TimeZone(abbreviation: "UTC")
//            let formattedDate = dateFormatterTemp.string(from: nextDay!)
//            let urlFormattedDate = formattedDate
//                    .replacingOccurrences(of: ":", with: "%3A") // Replace ':' with '%3A'
//                    .replacingOccurrences(of: "+", with: "%2B")
//            
//            let showsTemp: Shows = try await fetchQuery(url:getQueryURL(query: "shows?end=\(urlFormattedDate)&"))
//            
//            var index = 0
//            //get the personas associated with the show (show api call gives the link to the associated persona to then call)
//            for show in showsTemp.items{
//                let personasTemp : Persona = try await fetchQuery(url: show.links!.personas[0].href)
//                index+=1
//                let showTemp = ShowValues(showName:show.title!, djName:personasTemp.name, start:show.start!)
//                showModelTemp.append(showTemp)
//            }
//        } catch {
//            print("Failed to fetch shows: \(error)")
//        }
//        currShow = showModelTemp[0]
//        showModelTemp.removeFirst()
//        
//        shows.addShows(shows: showModelTemp)
//        isFetching = false
//    }
//    
//    //takes in a query and returns a url to call the api with the api-key
//    private func getQueryURL(query: String) -> String{
//        return "https://spinitron.com/api/\(query)access-token=\(apiKey)"
//    }
//
//    //this function repeatedly calls a fetch function to refresh in the view
//    func startRepeatedFetch(query: @escaping ()async -> Void, seconds: Int) {
//        Task{
//            while true{
//                await query()
//                print("refresh")
//                try? await Task.sleep(nanoseconds: UInt64(seconds) * 1_000_000_000)
//            }
//        }
//    }
//    //converts time given by api to regualar format ex. 12:13pm
//    func parseTime(time:String)->String{
//        let date = dateParser.date(from: time)
//                
//        //create timePraser to parse the time and date only
//        let timeParser = DateFormatter()
//        timeParser.dateFormat = "hh:mm a"
//                
//        let timeString = timeParser.string(from: date!)
//        return timeString
//
//    }
//    
//    //returns the first spin as a string
//    func getFirstSpin() -> String{
//        return "\(spins[0].song) - \(spins[0].artist)"
//        
//    }
//    //fetches image based on url
//    func fetchImage(url: String?) async throws -> Data?{
//        if url == nil{
//            return nil
//        }
//        let imageURL = URL(string: url!)
//        let (data, _) = try await URLSession.shared.data(from: imageURL!)
//        return data
//    }
//    
//}
//
//
////these structs are formated to be written to by the json's returned by the spinitron api
//struct Spins:Decodable{
//    var items : [Spin]
//    
//}
//
////class to hosd todays and tomorrows shows
////used to ogranize shows into today and tomorrow
//class ShowModel{
//    var today : [ShowValues]
//    
//    var tomorrow : [ShowValues]
//    let calendar = Calendar.current
//    var dater = DateFormatter()
//
//    
//    init(){
//        today = []
//        tomorrow = []
//        dater.locale = Locale(identifier: "en_US_POSIX")
//        dater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
//    }
//    //adds shows with todays date to today array
//    //adds shows with tomorrows data to tomorrow array
//    func addShows(shows: [ShowValues]){
//        let currentDate = Date()
//        var todayTemp : [ShowValues] = []
//        var tomorrowTemp : [ShowValues] = []
//        for show in shows{
//            //convert show.start to date
//            let showDate = dater.date(from: show.start)
//            if calendar.isDate(currentDate, inSameDayAs: showDate!){
//                
//                todayTemp.append(show)
//            }else{
//                tomorrowTemp.append(show)
//            }
//            
//        }
//        today = todayTemp
//        tomorrow = tomorrowTemp
//    }
//}
//
//
//class ShowValues{
//    let id = UUID()
//    var showName: String
//    var djName:String
//    var start:String
//    init(showName:String, djName: String, start:String){
//        self.showName = showName
//        self.djName = djName
//        self.start = start
//    }
//    
//    
//}
//struct Spin: Decodable{
//    let id = UUID()
//    let image : String?
//    let artist : String
//    let release : String?
//    let label: String?
//    let genre: String?
//    let released: Int?
//    let song: String
//    let time: String
//    //let date: String
//    
//    enum CodingKeys: String, CodingKey{
//        case image
//        case artist
//        case release
//        case label
//        case genre
//        case released
//        case song
//        case time = "start"
//    }
//    
//}
//
//
//
//// Persona response
//struct PersonaResponse: Decodable {
//    let items: [Persona]
//}
//
//// Persona (DJ or host)
//struct Persona: Decodable {
//    let id: Int
//    let name: String
//
//    
//}
//
//
//
//
//// Show response
//struct Shows: Decodable {
//    let items: [Show]
//
//}
//
//// Show item
//struct Show: Decodable {
//    let id: Int?
//    let start: String?
//    let end: String?
//    let title: String?
//    let links: ShowLinks?
//    
//    enum CodingKeys: String, CodingKey {
//        case id, start, end, title
//        case links = "_links"
//    }
//}
//
//// Show links for related resources
//struct ShowLinks: Decodable {
//    let personas: [Link]
//    
//}
//
//// Common Link struct for various relations (like personas, playlists)
//struct Link: Decodable {
//    let href: String
//}
//
//
//// Links struct for self-referencing links
//struct Links: Decodable {
//    let selfLink: Link
//    
//    enum CodingKeys: String, CodingKey {
//        case selfLink = "self"
//    }
//}
//
//
//
//
//
//
//
//
//
