//
//  ViewController.swift
//  TicTacTor
//
//  Created by Ivan Maslov on 05.06.2023.
//

import UIKit

class ViewController: UIViewController {

    enum Turn {
        case Noughts
        case Crosses
    }
    
    @IBOutlet weak var currentLabel: UILabel!
    
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var NOUGHT = "X"
    var CROSS = "O"
    
    var board = [UIButton]()
    
    var firstTurn = Turn.Noughts
    var currentTurn = Turn.Noughts
    
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
        
        if fullBoard() {
            resultAlert(title: "Draw")
        }
        
    }
    
    func resultAlert(title: String) {
        
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetBoard()
        }))
        self.present(ac, animated: true)
    }
    
    func resetBoard() {
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        
        if firstTurn == Turn.Noughts {
            firstTurn = Turn.Crosses
            currentLabel.text = CROSS
        } else if firstTurn == Turn.Crosses {
            firstTurn = Turn.Noughts
            currentLabel.text = NOUGHT
        }
        currentTurn = firstTurn
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
                currentLabel.text = CROSS
            } else if currentTurn == Turn.Crosses {
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Noughts
                currentLabel.text = NOUGHT
            }
            sender.isEnabled = false
            sender.setTitleColor(.black, for: .disabled)
        }
    }
    
    
}

