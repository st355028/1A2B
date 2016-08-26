//
//  ViewController.swift
//  HelloGuessNumber
//
//  Created by MinYeh on 2016/7/28.
//  Copyright © 2016年 MINYEH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var userGuessTextField: UITextField!
    @IBOutlet weak var inputATextField: UITextField!
    @IBOutlet weak var inputBTextField: UITextField!

    @IBOutlet weak var logTextView: UITextView!
    
    
    var host = GuessNumberHost()
    var ai = GuessNumberAI()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        logTextView.text = "Welecome,please guess it first!\n"
    }

    
    @IBAction func userGuessSubmitBtnPressed(sender: UIButton) {
        guard let userGuessString = userGuessTextField.text else{
            return
        }
        
        guard host.isVaildNumber(userGuessString) else{
            logTextView.text! += "Invalid input: \(userGuessString)\n"
            return
        }
        
        //Handle User Guess
        guard let resultAB = host.userGuess(userGuessString) else{
            logTextView.text! += "Fail to handle input:\(userGuessString)\n"
            return
        }
        
        logTextView.text! += "User Guess [\(host.userGuessCounter)]:\(userGuessString) ==> \(resultAB.A)A,\(resultAB.B)B\n"
        
        if resultAB.A == host.MAX_NUMBER{
            logTextView.text! += "User Win the game! \n"
            return
        }
        
        //It's AI's turn to guess
        guard let aiGuessString = ai.getAIGuess() else{
            logTextView.text! += "AI dont know how to guess. \n"
            return
        }
        
        logTextView.text! += "AI guess [\(ai.aiGuessCount)]:\(aiGuessString)\n"
    }
    
    @IBAction func replyABBtnPressed(sender: UIButton) {
        
        // check if the input are vaild
        guard let replyA = inputATextField.text else {
            logTextView.text! += "Field A should not be empty.\n"
            return
        }
        
        guard let replyB = inputBTextField.text else {
            logTextView.text! += "Field B should not be empty.\n"
            return
        }
        
        guard let numberA = Int(replyA) else{
            logTextView.text! += "Field A is not vaild.\n"
            return
        }
        
        guard let numberB = Int(replyB) else{
            logTextView.text! += "Field B is not vaild.\n"
            return
        }
        
        
        //Handle user's reply of AB
        guard let result = ai.handleUserReply(numberA, replyB: numberB) else{
            logTextView.text! += "AI don't know how to handle the AB.\n"
            return
        }
        
        if result{
            logTextView.text! += "AI win the game.\n"
        }else{
            logTextView.text! += "==> \(numberA)A,\(numberB)B.\n Your turn to guess. \n"
            return
        }
    }
    
    @IBAction func restartGameBtnPressed(sender: UIButton) {
        logTextView.text! += "Game restart , please guess it first. \n"
        host = GuessNumberHost()
        ai = GuessNumberAI()
        
        //Clear up the Fields
        userGuessTextField.text = ""
        inputATextField.text = ""
        inputBTextField.text = ""

    }
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

