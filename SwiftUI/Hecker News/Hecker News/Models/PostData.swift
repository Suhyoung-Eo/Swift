//
//  PostData.swift
//  Hecker News
//
//  Created by Suhyoung Eo on 2021/09/15.
//

import Foundation

struct Results: Decodable {
    let hits: [Post]
}

struct Post: Decodable, Identifiable {
    var id: String {
        return objectID
    }
    let objectID: String
    let points: Int
    let title: String
    let url: String?
}
