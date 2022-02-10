//
//  ContentView.swift
//  HackerNewsTV
//
//  Created by Dakota Kim on 2/6/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var results: Array<Int> = []
    
    func fetchTopStories() async {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            print("DATA : \(data)")

            if let decodedResponse = try? JSONDecoder().decode(Array<Int>.self, from: data) {
                
                
                print("RESULT: \(decodedResponse)")
                
                let topTwentyFive = Array(decodedResponse[0...24])
                
                results = topTwentyFive
                
                topTwentyFive.forEach { storyId in
                    print("StoryID: \(storyId)")
                }
            }
            
        } catch {
            print("Invalid data")
        }
        
    }
    
    var body: some View {
        VStack {
            Button {
                print("Fetching posts from HN")
                Task {
                    await fetchTopStories()
                }
            } label: {
                Text("Fetch posts...")
            }.foregroundColor(.orange)
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
