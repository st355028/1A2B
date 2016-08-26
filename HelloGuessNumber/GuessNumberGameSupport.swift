//
//  GuessNumberGameSupport.swift
//  HelloGuessNumber
//
//  Created by MinYeh on 2016/7/28.
//  Copyright © 2016年 MINYEH. All rights reserved.
//

import Foundation

class GuessNumberBase{
    //The game just has 4 number can input
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
    
    
    func checkAB(testInput:String,answerInput:String) -> (A:Int,B:Int)?{
        
        ///Check if inputs are valid
        guard isVaildNumber(testInput) && isVaildNumber(answerInput) else
        {
            return nil
        }
        
        
        //Check A B
        let testArray = Array(testInput.characters)
        let answerArray  = Array(answerInput.characters)
        
        var resultA = 0
        var resultB = 0
        
        for i in 0..<MAX_NUMBER{
            for j in 0..<MAX_NUMBER{
                if testArray[i] == answerArray[j]{
                    if i == j {
                        resultA += 1
                    }else{
                        resultB += 1
                    }
                }
            }
        }
        return (A:resultA,B:resultB)
    }
}
    
class GuessNumberHost:GuessNumberBase {
        private var appNumberString = ""
        
        //readOnly 寫法
        private(set) var userGuessCounter = 0
        
        //When GuessNumberHost was created , it will auto run
        override init(){
            super.init()
            generateAppNumberString()
        }
        
        private func generateAppNumberString()
        {
            
            var availables = ["0","1","2","3","4","5","6","7","8","9"]
            
            for _ in 0..<MAX_NUMBER {
                
                //因為arc4random()回傳形態是Uint32，而availables.count是Int，所以要先把availables.count轉成UInt32，而availables[tmpIndex]裡的tmpIndex只吃Int，所以整體運算完在轉Int
                let tmpIndex = Int(arc4random() % UInt32(availables.count))
                
                let tmpNumber = availables[tmpIndex]
                
                appNumberString += tmpNumber
                
                availables.removeAtIndex(tmpIndex)
            }
            
            print("appNumberString:\(appNumberString)")
        }
        
        func userGuess(userInput:String) -> (A:Int,B:Int)?{
            let resultAB = checkAB(userInput, answerInput: appNumberString)
            
            guard resultAB != nil else{
                return nil
            }
            
            userGuessCounter += 1
            
            return resultAB
        }
}
    





class GuessNumberAI:GuessNumberBase{
    private var allPossibilities = [String]()
    private(set) var lastAIGuessString:String?
    private(set) var aiGuessCount = 0
    
    
    override init(){
        super.init()
        generateAllPossibilities()
    }
    
    
    private func generateAllPossibilities(){
        // 0123 ~ 9876
        
        for i in 0123...9876{
            //"%04d" 當不足4位補0當開頭
            let tmp = String(format: "%04d",i)
            if isVaildNumber(tmp){
                allPossibilities.append(tmp)
            }
        }
        
        
        print("Total \(allPossibilities.count) possible numbers.")
    }
    
    // MARK: - Public Methods
    func getAIGuess() -> String?{
        
        guard allPossibilities.count > 0 else{
            return nil
        }
        
        let targetIndex = Int(arc4random() % UInt32(allPossibilities.count))
        
        lastAIGuessString = allPossibilities[targetIndex]
        
        aiGuessCount += 1
        
        return lastAIGuessString
    }
    
    func handleUserReply(replyA:Int,replyB:Int) -> Bool?{
        
        guard allPossibilities.count > 0 && lastAIGuessString != nil else{
            return nil
        }
        
        //Check if AI Win the game
        if replyA == MAX_NUMBER {
            return true
        }
        
        //Filter and keep possible numbers
        var newPossibilities = [String]()
        
        for tmp in allPossibilities{
            guard let tmpAB = checkAB(tmp, answerInput: lastAIGuessString!) else{
                return nil
            }
            
            if tmpAB.A == replyA && tmpAB.B == replyB{
                newPossibilities.append(tmp)
            }
            
            allPossibilities = newPossibilities
            
            print("Total \(allPossibilities.count) possible nmbers.")
        }
        
        
        return false
        
    }
    
    
    
    
}