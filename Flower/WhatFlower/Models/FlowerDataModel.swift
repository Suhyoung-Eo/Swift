//
//  DataModel.swift
//  WhatFlower
//
//  Created by Suhyoung Eo on 2021/10/24.
//

import Foundation

struct FlowerDataModel: Codable {
    let query: Query    //reference to srtucture
    
    struct Query: Codable { // query dictionary
        let pages: [String: Result] // String is the changing pageid
    }
}

struct Result: Codable {
    let title: String
    let extract: String
    let pageimage: String
    let thumbnail: Thumbnail
}

struct Thumbnail: Codable {
    let source: String
}

