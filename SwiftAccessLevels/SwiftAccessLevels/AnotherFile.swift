//
//  AnotherFile.swift
//  SwiftAccessLevels
//
//  Created by Suhyoung Eo on 2021/10/18.
//

import Foundation

class AnotherClassInAnotherFile {
    let aClass = AClass()
    
    init() {
        
        //Step 8. Try to print aFilePrivateProperty Here - Impossible
        //print("\(aClass.aFilePrivateProperty) printed from init of AnotherClassAnotherFile")
        
        //Step 10. Try to print anInternalProperty Here _ Possible
        //print("\(aClass.anInternalProperty) printed from init of AnotherClassAnotherFile")
    }
 }
