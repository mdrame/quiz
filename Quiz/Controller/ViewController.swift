//
//  ViewController.swift
//  Quiz
//
//  Created by Mohammed Drame on 11/23/19.
//  Copyright © 2019 Mo Drame. All rights reserved.

// TODO: Add timmer in app
//

import UIKit

class ViewController: UIViewController {
    
    
/* track siebar button stage but its ishidden method */

   
    // Global variables, list, dict etc
    // colors in lower case so i can use for both uicolor names .text property
    var randomColor: [String] = ["red", "yellow", "blue", "black", "orange", "skyblue", "pink", "green", "purple", "white"]

    var textColorDict : [String: UIColor] = ["red": .red,
                                             "yellow": .yellow,
                                             "blue": .blue,
                                             "pink": .gray,
                                             "purple":.purple,
                                             "ornage": .orange,
                                             "skyblue": .green,
                                             "black": .black ]
    
    
    
    
        
    
    
    var timer = Timer() // timmer instance
    var scoreCount = 0 // keep track of how many answer user got right and wrong
    var correctAnswer: Int? // keeps track of textColor and .text stage ( 0 / 1 )
    var correctBool = "NOTHING" // keeping track of correctAnswer and sender.tags = 0/1
    var counter = 5 // counter will decrease by 1 ever time the sixtySecondTimer function runs
    
    
    
    // IBOutlets
    @IBOutlet weak var sideBarCollection: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet var true_false_outlet: [UIButton]!
    @IBOutlet weak var scoreLabelOutlet: UILabel!
    
    @IBOutlet weak var sideBarView: UIView!
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    
      @IBOutlet var countDownLabel: UILabel!
    
    
    
    
    // UIFunctions ( In-order to not occupy viewDidLoad func )
    
    func uiButtonsDesigned() {
        
        // sidde button designs
        sideBarCollection.layer.borderWidth = 3.0
        sideBarCollection.layer.borderColor = #colorLiteral(red: 1, green: 0.2256877422, blue: 0.0854042545, alpha: 1)
        sideBarCollection.layer.cornerRadius = 10.0
        
    }
    
    
  

  
    /*  assigningTittle set UIOutlet properties and keep stage of textColr and .text product */
    
    func assigningTittle() {
        
        randomColor.shuffle() // shuffle array
        let title = randomColor[0] // shuffle array and give the first element
        let shuffledTextColor = textColorDict.shuffled()
       
        
        let gameStage  = 0
        
        for (key, value) in shuffledTextColor {
            // don't need gameStage constent at all ( Debugging ).
            if gameStage == 0 {
                resultLabel.text = title
                resultLabel.textColor = value
            }
            if key == title { // if dictionary key and lable is or is not the same then correct answer keep satge
                correctAnswer = 0
            } else {
                correctAnswer = 1
            }
        }
        
    
      
    
    } // assigningTittle ends here
    

    func sixtySecondTImer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(counting), userInfo: nil, repeats: true)
    }
    
    @objc func counting() {
        if counter >= 0 {
            countDownLabel.text = "Counter: \(counter)"
            counter -= 1
        } else {
            // create a ULAlertControl tellING the user that the game is over and enabling them to push restart
            // refuse to do this inits seperate func because I wont need it anymore don't worry.
            timer.invalidate()
            let alert = UIAlertController(title: "Game Over", message: "Start Over", preferredStyle: .alert) // programmatic AlertCntr. Do they even have a UI type.
            let restartGame = UIAlertAction(title: "YES", style: .default) { (UIAlertAction) in
                // Reset every UI view item to origin stage.
                self.counter = 5
                self.assigningTittle()
                self.sixtySecondTImer() // if alert button is press run the timmer function
            }
            alert.addAction(restartGame)
            self.present(alert, animated: true, completion: nil)
            
        }
    }

   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        uiButtonsDesigned()
        
        assigningTittle()
        // when view loads side bar button start from the side.
        dissSideBar()
        
         // reset timer ever time viewdIDlOAD
        sixtySecondTImer()
        
        
    }
    
    
    
    
    
    func showSideBar() {
        
        UIView.animate(withDuration: 0.5) {
            self.sideBarView.transform = CGAffineTransform(translationX:0, y: 0)
        }
    }
    
    func dissSideBar() {
        UIView.animate(withDuration: 0.5) {
                          self.sideBarView.transform = CGAffineTransform(translationX: -205, y: 0)
                      }
    }
    
  
    
    
    

    
    // IBActions
    @IBAction func sideBarAction(_ sender: UIButton) {
        
        showSideBar()
        sideBarCollection.isHidden =  true
        }
        
    
    
    
    
    
    // True and False button
    @IBAction func action(_ sender: UIButton) {
        

        timer.invalidate() // stop time when ever buttons arre press
        counter = 5 // reset timer to 5 so timer can restart
        sixtySecondTImer()
        
        if sender.tag == 0 && correctAnswer! == 0 { // if true
            scoreCount += 1
            correctBool = "Correct"
            scoreLabelOutlet.text = "\(scoreCount)"
            assigningTittle()
        } else if sender.tag == 1 && correctAnswer! == 1 { // if true
            scoreCount += 1
            correctBool = "Correct"
            scoreLabelOutlet.text = "\(scoreCount)"
            assigningTittle()
        } else if sender.tag == 0 && correctAnswer! == 1 { // if false
            scoreCount -= 1
            correctBool = "Wrong"
            scoreLabelOutlet.text = "\(scoreCount)"
            assigningTittle()
        } else if sender.tag == 1 && correctAnswer! == 0 { // if false
            scoreCount -= 1
            correctBool = "Wrong"
            scoreLabelOutlet.text = "\(scoreCount)"
            assigningTittle()
        } else {                                    // default
            correctBool = "Nothing Bro"
            scoreLabelOutlet.text = "\(scoreCount)"
            assigningTittle()
        }
    
        print(correctBool)
    
    }
    
    
    @IBAction func tapGestureTaped(_ sender: UITapGestureRecognizer) {
        
        dissSideBar()
        sideBarCollection.isHidden = false
        
        
    }
    
    
    
    
 
    
    
    
    


}

