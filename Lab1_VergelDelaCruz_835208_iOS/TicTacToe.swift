//
//  TicTacToe.swift
//  Lab1_VergelDelaCruz_835208_iOS
//
//  Created by user209721 on 1/18/22.
//

import Foundation

class TicTacToe {
    private var currentPlayer:Int = 1
    private var isActive:Bool = true
    private var squareStates = [0,0,0,0,0,0,0,0,0]
    private var player1Score = 0;
    private var player2Score = 0
    
    private let winningCombinations = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6,], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    private var player1Won:Bool = false
    private var player2Won:Bool = false
    private var draw:Bool = false
    
    public func getCurrentPlayer() -> Int {
        return self.currentPlayer
    }
    public func setCurrentPlayer(player:Int) {
        self.currentPlayer = player
    }
    public func isGameActive() -> Bool {
        return self.isActive
    }
    public func setGameActive(active:Bool) {
        self.isActive = active
    }
    public func getSquareStates() -> [Int] {
        return self.squareStates
    }
    public func setSquareStates(states:[Int]) {
        self.squareStates = states
    }
    public func setSquareState(element:Int, value:Int) {
        self.squareStates[element] = value
    }
    public func getPlayer1Score() -> Int {
        return self.player1Score
    }
    public func setPlayer1Score(score:Int) {
        self.player1Score = score
    }
    public func getPlayer2Score() -> Int {
        return self.player2Score
    }
    public func setPlayer2Score(score:Int) {
        self.player2Score = score
    }
    public func didPlayer1Won() -> Bool {
        return player1Won
    }
    public func didPlayer2Won() -> Bool {
        return player2Won
    }
    public func isDraw() -> Bool {
        return draw
    }
    public func checkWinner() {
        for combination in self.winningCombinations {
            if self.getSquareStates()[combination[0]] != 0 && self.getSquareStates()[combination[0]] == self.getSquareStates()[combination[1]] && self.getSquareStates()[combination[1]] == self.getSquareStates()[combination[2]] {
                self.setGameActive(active: false)
                if self.getSquareStates()[combination[0]] == 1 {
                    self.setPlayer1Score(score: self.getPlayer1Score() + 1)
                    self.player1Won = true
                } else {
                    self.setPlayer2Score(score: self.getPlayer2Score() + 1)
                    self.player2Won = true
                }
            }
        }
        if self.allUsedSquare() && isGameActive() == true {
            self.draw = true
            self.setGameActive(active: false)
        }
    }
    private func allUsedSquare() -> Bool {
        var allUsed = true
        for i in self.getSquareStates() {
            if (i == 0) {
                allUsed = false
                break;
            }
        }
        return allUsed
    }
    public func reset() {
        self.setCurrentPlayer(player: 1)
        self.setGameActive(active: true)
        self.setSquareStates(states: [0,0,0,0,0,0,0,0,0])
        self.player1Won = false
        self.player2Won = false
        self.draw = false
    }
}
