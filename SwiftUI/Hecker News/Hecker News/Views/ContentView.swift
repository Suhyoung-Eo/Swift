//
//  ContentView.swift
//  Hecker News
//
//  Created by Suhyoung Eo on 2021/09/15.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    //Xcode auto creative form
    var body: some View {
        NavigationView {
            List(networkManager.posts) { post in
                NavigationLink(
                    destination: DetailView(url: post.url),
                    label: {
                        HStack {
                            Text("\(post.points)")
                            Text(post.title)
                        }
                    })
            }
            .navigationTitle("Heker News")
        }
        .onAppear(perform: {
            self.networkManager.fetchData()
        })
        
        //Angela 강의 내용
        //    var body: some View {
        //        NavigationView {
        //            List(networkManager.posts) { post in
        //                NavigationLink(destination: DetailView(url: post.url)) {
        //                    HStack {
        //                        Text("\(post.points)")
        //                        Text(post.title)
        //                    }
        //                }
        //            }
        //            .navigationTitle("Heker News")
        //        }
        //        .onAppear {
        //            self.networkManager.fetchData()
        //        }
        //    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//struct Post: Identifiable {
//    let id: String
//    let title: String
//}

//let posts = [
//    Post(id: "1", title: "Hello"),
//    Post(id: "2", title: "Bonjout"),
//    Post(id: "3", title: "Halo")
//]
