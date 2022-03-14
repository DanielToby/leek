//
//  oxford_query_utility.swift
//  leek
//
//  Created by Daniel Toby on 2/21/22.
//

import Foundation

func queryOxfordDefinitions(query: String, completion: @escaping (WordData) -> Void) {
    print("Querying Oxford API for definition of '\(query)'.")
    let appId = "14ea1384"
    let appKey = "8fa1a68b06feb6f81edeec419b965e45"
    let fields = "definitions%2Cpronunciations"
    let strictMatch = "false"
    let word_id = query.lowercased()
    if let url = URL(string: "https://od-api.oxforddictionaries.com:443/api/v2/entries/en-gb/\(word_id)?fields=\(fields)&strictMatch=\(strictMatch)") {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(appId, forHTTPHeaderField: "app_id")
        request.addValue(appKey, forHTTPHeaderField: "app_key")
        
        let session = URLSession.shared
        session.dataTask(with: request, completionHandler: { data, response, error in
            
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                do {
                    let oxfordResponse = try JSONDecoder().decode(OxfordResponse.self, from: data)
                    if (oxfordResponse.results.count > 0) {
                        DispatchQueue.main.async {
                            print("Found definition of '\(query)'.")
                            completion(oxfordResponse.results[0])
                        }
                    }
                } catch(let error) {
                    print("Error deserializing data: \(error)")
                }
            }
        }).resume()
    }
}

func queryOxfordSearchResults(query: String) async -> Array<String>? {
    let appId = "14ea1384"
    let appKey = "8fa1a68b06feb6f81edeec419b965e45"
    let limit = 3
    if let url = URL(string: "https://od-api.oxforddictionaries.com:443/api/v2/search/en-gb?q=\(query)&prefix=true&limit=\(limit)") {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(appId, forHTTPHeaderField: "app_id")
        request.addValue(appKey, forHTTPHeaderField: "app_key")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            print("Search query response: \(response)")
            let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            print(jsonData)
        } catch {
            print(error)
        }
    }
    return nil
}
