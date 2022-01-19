//
//  ViewController.swift
//  Lab1_VergelDelaCruz_835208_iOS
//
//  Created by user209721 on 1/17/22.
//

import UIKit

class ViewController: UIViewController {

    var ticTacToe = TicTacToe()
    @IBOutlet weak var lblPlayer1Score: UILabel!
    @IBOutlet weak var lblPlayer2Score: UILabel!
    @IBOutlet weak var lblGameMsg: UILabel!
    @IBOutlet weak var lblPlayAgainMsg: UILabel!
    
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
        if (ticTacToe.isGameActive()) {
            if (ticTacToe.getSquareStates()[sender.tag - 1] == 0) {
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
                lblGameMsg.text = "Player 1 has won"
            }
            if ticTacToe.didPlayer2Won() {
                lblPlayer2Score.text = String(ticTacToe.getPlayer2Score())
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
    
}

