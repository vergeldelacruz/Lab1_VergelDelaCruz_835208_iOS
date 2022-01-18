//
//  ViewController.swift
//  Lab1_VergelDelaCruz_835208_iOS
//
//  Created by user209721 on 1/17/22.
//

import UIKit

class ViewController: UIViewController {

    var currentPlayer = 1
    var squareStates = [0,0,0,0,0,0,0,0,0]
    let winningCombinations = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6,], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    var isActive = true
    
    @IBOutlet weak var lblPlayer1Score: UILabel!
    @IBOutlet weak var lblPlayer2Score: UILabel!
    @IBOutlet weak var lblGameMsg: UILabel!
    @IBOutlet weak var lblPlayAgainMsg: UILabel!
    
    var player1Score = 0;
    var player2Score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblGameMsg.isHidden = true
        lblPlayAgainMsg.isHidden = true
        lblPlayer1Score.text = "0"
        lblPlayer2Score.text = "0"
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
    @IBAction func clicked(_ sender: UIButton) {
        if (isActive) {
            if (squareStates[sender.tag - 1] == 0) {
                squareStates[sender.tag - 1] = currentPlayer
                if (currentPlayer == 1) {
                    currentPlayer = 2
                    sender.setImage(UIImage(named: "cross"), for: UIControl.State())
                } else {
                    currentPlayer = 1
                    sender.setImage(UIImage(named: "nought"), for: UIControl.State())
                }
            }
            for combination in winningCombinations {
                if squareStates[combination[0]] != 0 && squareStates[combination[0]] == squareStates[combination[1]] && squareStates[combination[1]] == squareStates[combination[2]] {
                    isActive = false
                    if squareStates[combination[0]] == 1 {
                        player1Score+=1
                        lblPlayer1Score.text = String(player1Score)
                        lblGameMsg.text = "Player 1 has won"
                    } else {
                        player2Score+=1
                        lblPlayer2Score.text = String(player2Score)
                        lblGameMsg.text = "Player 2 has won"
                    }
                    lblGameMsg.isHidden = false
                    lblPlayAgainMsg.isHidden = false
                }
            }
            if allUsedSquare() && isActive == true {
                lblGameMsg.isHidden = false
                lblGameMsg.text = "We have a draw"
                isActive = false
                lblPlayAgainMsg.isHidden = false
            }
        }
    }
    func allUsedSquare() -> Bool {
        var allUsed = true
        for i in squareStates {
            if (i == 0) {
                allUsed = false
                break;
            }
        }
        return allUsed
    }
    func playAgain() {
        currentPlayer = 1
        isActive = true
        squareStates = [0,0,0,0,0,0,0,0,0]
        lblGameMsg.isHidden = true
        lblPlayAgainMsg.isHidden = true
        for i in 1...9 {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil,for: UIControl.State())
        }
    }
    
}

