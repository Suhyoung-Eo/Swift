//
//  FlowerModel.swift
//  WhatFlower
//
//  Created by Suhyoung Eo on 2021/10/24.
//

import Foundation

struct FlowerDataViewModel {
    private let result: Result
    
    init(_ result: Result) {
        self.result = result
    }
    
    var title: String {
        return result.title
    }
    var extract: String {
        return result.extract
    }
    var pageImgae: String {
        return result.pageimage
    }
    var thumbnailLink: URL? {
        return URL(string: result.thumbnail.source)
    }
}
