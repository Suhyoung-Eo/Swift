//
//  AFile.swift
//  SwiftAccessLevels
//
//  Created by Suhyoung Eo on 2021/10/18.
//

import Foundation

class AClass {
    //Global variables, also called class properties.
    private var aPrivateProperty = "private property"
    fileprivate var aFilePrivateProperty = "filePrivate property"
    var anInternalProperty = "internal property"
    
    func methodA() {
        
        var aLocalVariable = "local variable"
        
        //Step 1. Try to print aLocalVariable Here - Possible
        //print("\(aLocalVariable) printed from methodA in Aclass")
        
        //Step 3. Try to print aPrivateProperty Here - Pssible
        //print("\(aPrivateProperty) printed from methodA in Aclass")
        
        //Step 6. Try to print aFilePrivateProperty Here - Possible
        //print("\(aFilePrivateProperty) printed from methodA in Aclass")
        
        //Step 9. Try to print anInternalProperty Here - Possible
        print("\(anInternalProperty) printed from methodB in Aclass")
        
    }
    
    func methodB () {
        
        //Step 2. Try to print aLocalVariable Here - Impossible
        //print("\(aLocalVariable) printed from methodB in Aclass")
        
        //Step 4. Try to print aPrivateProperty Here - Possible
        //print("\(aPrivateProperty) printed from methodB in Aclass")
    }
}

class AnotherClassInTheSameFile {
    
    let aClass = AClass()
    init() {
        
        //Step 5. Try to print aPrivateProperty Here - Impossible
        //print("\(aClass.aPrivateProperty) print from init in AnotherClassTheSameFile")
        
        //Step 7. Try to print aFilePrivateProperty Here - Possble
        //print("\(aClass.aFilePrivateProperty) printed fron init of AnotherClassTheSameFile")
    }
}
