//
//  ViewController.swift
//  TicTacTor
//
//  Created by Ivan Maslov on 05.06.2023.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    enum Turn {
        case Crosses
        case Noughts
    }
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var CROSS = "X"
    var NOUGHT = "O"
    var board = [UIButton]()
    
    var crossesWinScore = 0
    var noughtsWinScore = 0
    
    var firstTurn = Turn.Crosses
    var currentTurn = Turn.Crosses
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initBoard()
    }

    func initBoard() {
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
    }
    
    @IBAction func boardTapAction(_ sender: UIButton) {
        addToBoard(sender)
        
        if checkForVictory(CROSS) {
            crossesWinScore += 1
            resultAlert(title: "Crosses Win!")
        }
        if checkForVictory(NOUGHT) {
            noughtsWinScore += 1
            resultAlert(title: "Noughts Win!")
        }
        if fullBoard() {
            resultAlert(title: "Draw...")
        }
    }
    
    func checkForVictory(_ s: String) -> Bool {
        
        //Horizontal Victory
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s) {
            return true
        }
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s) {
            return true
        }
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s) {
            return true
        }
        
        //Vertical Victory
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s) {
            return true
        }
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s) {
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s) {
            return true
        }
        
        //Diagonal Victory
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s) {
            return true
        }
        if thisSymbol(c1, s) && thisSymbol(b2, s) && thisSymbol(a3, s) {
            return true
        }
        return false
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(title: String) {
        let ac = UIAlertController(title: title, message: "", preferredStyle: .actionSheet)
        let titleAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 20)!]
        let titleString = NSAttributedString(string: title, attributes: titleAttributes)
        let messageAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 16)!]
        let messageString = NSAttributedString(string: "crosses \(crossesWinScore):\(noughtsWinScore) noughts", attributes: messageAttributes)

        ac.setValue(titleString, forKey: "attributedTitle")
        ac.setValue(messageString, forKey: "attributedMessage")
        ac.addAction(UIAlertAction(title: "Reset score and restart", style: .destructive, handler: { (_) in
            self.resetBoard()
            self.resetScore()
        }))
        ac.addAction(UIAlertAction(title: "Restart game", style: .cancel, handler: { (_) in
            self.resetBoard()
        }))
        
        self.present(ac, animated: true)
    }
    
    func resetBoard() {
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        
        if currentTurn == Turn.Noughts {
            firstTurn = Turn.Noughts
            turnLabel.text = NOUGHT
        } else if currentTurn == Turn.Crosses {
            firstTurn = Turn.Crosses
            turnLabel.text = CROSS
        }
        currentTurn = firstTurn
    }
    
    func resetScore() {
        crossesWinScore = 0
        noughtsWinScore = 0
    }
    
    func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal) == nil {
                return false
            }
        }
        return true
    }
    
    func addToBoard(_ sender: UIButton) {
        if sender.title(for: .normal) == nil {
            if currentTurn == Turn.Noughts {
                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = Turn.Crosses
                turnLabel.text = CROSS
            } else if currentTurn == Turn.Crosses {
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Noughts
                turnLabel.text = NOUGHT
            }
            sender.isEnabled = false
            sender.setTitleColor(.black, for: .disabled)
        }
    }
}

