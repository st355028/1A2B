//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let MAX_NUMBER = 4

func isVaildNumber(input:String) -> Bool{
    
    //Check Lenght
    let inputLenght = input.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
    
    guard inputLenght == MAX_NUMBER else{
        return false
    }
    
    //Check if it is a number
    guard Int(input) != nil else{
        return false
    }
    
    //Check if there is any duplicate number(重複數字)
    let inputSet = Set(input.characters)
    
    guard inputSet.count == MAX_NUMBER else{
        return false
    }
    
    return true
}


isVaildNumber("1")
