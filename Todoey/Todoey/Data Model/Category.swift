//
//  Category.swift
//  Todoey
//
//  Created by Suhyoung Eo on 2021/10/08.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
}
