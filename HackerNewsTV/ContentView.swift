//
//  ContentView.swift
//  HackerNewsTV
//
//  Created by Dakota Kim on 2/6/22.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var by: String
    var id: Int
    var score: Int
    var text: String
    var time: Int
    var title: String
    var type: String
    var url: String
    
}

struct ContentView: View {
    
    @State private var results = [Result]()
    
    func fetchCurrentPosts() async {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/192327.json?print=pretty") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            print("DATA : \(data)")

            if let decodedResponse = try? JSONDecoder().decode(Result.self, from: data) {
                
                
                print("RESULT: \(decodedResponse)")
            }
        } catch {
            print("Invalid data")
        }
        
    }
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
            Button {
                print("Fetching posts from HN")
                Task {
                    await fetchCurrentPosts()
                }
            } label: {
                Text("Fetch posts...")
            }
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
