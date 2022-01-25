//
//  ViewController.swift
//  Lab1_VergelDelaCruz_835208_iOS
//
//  Created by user209721 on 1/17/22.
//

import UIKit

class ViewController: UIViewController {

    var ticTacToe = TicTacToe()
    var playerScore = [PlayerScore]()
    @IBOutlet weak var lblPlayer1Score: UILabel!
    @IBOutlet weak var lblPlayer2Score: UILabel!
    @IBOutlet weak var lblGameMsg: UILabel!
    @IBOutlet weak var lblPlayAgainMsg: UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
        fetchPlayerScores()
        
        lblGameMsg.isHidden = true
        lblPlayAgainMsg.isHidden = true
        
        // Add swipe gestures to reset and play the game again
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        view.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        view.addGestureRecognizer(swipeRight)
        let swipeUp = UISwipeGestureRecognizer(target:self, action: #selector(swiped))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        view.addGestureRecognizer(swipeUp)
        let swipeDown = UISwipeGestureRecognizer(target:self, action: #selector(swiped))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        view.addGestureRecognizer(swipeDown)
    }
    @objc func swiped(gesture: UISwipeGestureRecognizer) {
        let swipeGesture = gesture as UISwipeGestureRecognizer
        switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                playAgain()
            case UISwipeGestureRecognizer.Direction.right:
                playAgain()
            case UISwipeGestureRecognizer.Direction.up:
                playAgain()
            case UISwipeGestureRecognizer.Direction.down:
                playAgain()
            default:
                break
        }
    }
    // shake motion

     override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {

         if event?.subtype == UIEvent.EventSubtype.motionShake {
            
             if ticTacToe.isGameActive() && ticTacToe.getLastButton()  != -1 {
                 ticTacToe.setSquareState(element: ticTacToe.getLastButton() - 1 , value: 0)
                 if ticTacToe.getCurrentPlayer() == 1 {
                    ticTacToe.setCurrentPlayer(player: 2)
                 } else {
                     ticTacToe.setCurrentPlayer(player: 1)
                 }
                 let button = view.viewWithTag(self.ticTacToe.getLastButton()) as! UIButton
                 button.setImage(nil,for: UIControl.State())
                 
                 print("undo")
                 ticTacToe.setLastButton(lastButton: -1)
             }

         }

     }

    @IBAction func clicked(_ sender: UIButton) {
        if (ticTacToe.isGameActive()) {
            if (ticTacToe.getSquareStates()[sender.tag - 1] == 0) {
                ticTacToe.setLastButton(lastButton: sender.tag )
                ticTacToe.setSquareState(element: sender.tag - 1, value: ticTacToe.getCurrentPlayer())
                if (ticTacToe.getCurrentPlayer() == 1) {
                    ticTacToe.setCurrentPlayer(player: 2)
                    sender.setImage(UIImage(named: "cross"), for: UIControl.State())
                } else {
                    ticTacToe.setCurrentPlayer(player: 1)
                    sender.setImage(UIImage(named: "nought"), for: UIControl.State())
                }
            }
            ticTacToe.checkWinner()
            if ticTacToe.didPlayer1Won() {
                lblPlayer1Score.text = String(ticTacToe.getPlayer1Score())
                savePayer1Score(score: ticTacToe.getPlayer1Score())
                lblGameMsg.text = "Player 1 has won"
            }
            if ticTacToe.didPlayer2Won() {
                lblPlayer2Score.text = String(ticTacToe.getPlayer2Score())
                savePayer2Score(score: ticTacToe.getPlayer2Score())
                lblGameMsg.text = "Player 2 has won"
            }
            if ticTacToe.isDraw() {
                lblGameMsg.isHidden = false
                lblGameMsg.text = "We have a draw"
                ticTacToe.setGameActive(active: false)
                lblPlayAgainMsg.isHidden = false
            }
            if ticTacToe.isGameActive() == false {
                lblGameMsg.isHidden = false
                lblPlayAgainMsg.isHidden = false
            }
        }
    }
    
    func playAgain() {
        ticTacToe.reset()
        lblGameMsg.isHidden = true
        lblPlayAgainMsg.isHidden = true
        for i in 1...9 {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil,for: UIControl.State())
        }
    }
    
    func fetchPlayerScores() {
        do {
            self.playerScore = try context.fetch(PlayerScore.fetchRequest())
            if self.playerScore.isEmpty {
                createScores()
            } else {
                for i in 0...1 {
                    print(self.playerScore[i].player)
                    print(self.playerScore[i].score)
                    if ( self.playerScore[i].player  == 1) {
                        ticTacToe.setPlayer1Score(score: Int(self.playerScore[i].score))
                        lblPlayer1Score.text = String(ticTacToe.getPlayer1Score())
                    }
                    if ( self.playerScore[i].player  == 2) {
                        ticTacToe.setPlayer2Score(score: Int(self.playerScore[i].score))
                        lblPlayer2Score.text = String(ticTacToe.getPlayer2Score())
                    }
                }
                
                //self.context.delete( self.playerScore[1])
                //self.context.delete(self.playerScore[0])
                //saveScores()
            }
        } catch {
            print(error)

        }
    }
    
    func createScores() {
        print("create scores")
        let playerScore1 = PlayerScore(context: context)
        playerScore1.player = 1
        playerScore1.score = 0
        let playerScore2 = PlayerScore(context: context)
        playerScore2.player = 2
        playerScore2.score = 0
        do {
            try self.context.save()
        } catch {
            print(error)
        }
        lblPlayer1Score.text = "0"
        lblPlayer2Score.text = "0"
    }
    
    func savePayer1Score(score :Int) {
        print("save score for plyaer 1")
        for i in 0...1 {
            if self.playerScore[i].player  == 1 {
                self.playerScore[i].score = Int16(score)
            }
        }
        saveScores()
    }
    func savePayer2Score(score :Int) {
        print("save score for player 2")
        for i in 0...1 {
            if self.playerScore[i].player  == 2 {
                self.playerScore[i].score = Int16(score)
            }
        }
        saveScores()
    }
    
    func saveScores() {
        do {
            try self.context.save()
        } catch {
            print(error)
        }
    }
         
    
}

