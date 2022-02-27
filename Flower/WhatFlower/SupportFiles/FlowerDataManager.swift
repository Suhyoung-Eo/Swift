//
//  DataManager.swift
//  WhatFlower
//
//  Created by Suhyoung Eo on 2021/10/24.
//

import Alamofire

struct FlowerDataManager {
    
    static let shared = FlowerDataManager()
    
    func performRequest(with urlString: String, completion: @escaping (Result?) -> Void) {
        AF.request(urlString).validate().responseDecodable(of: FlowerDataModel.self) { response in
            guard let value = response.value else { completion(nil); return }
            let pages = value.query.pages
            if let pageId = pages.first?.key {
                let result = pages[pageId]
                completion(result)
            } else {
                completion(nil)
            }
        }
        
    }
    
    private init() {}
}
