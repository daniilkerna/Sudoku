//
//  ViewController.swift
//  Sudoku
//
//  Created by Daniil K on 3/1/18.
//  Copyright © 2018 Daniil K. All rights reserved.
//

import UIKit

class PuzzleViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var pencilButton: UIButton!
    @IBOutlet weak var puzzleView: SudokuView!
    var pencilEnabled: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Clear Board", style: UIAlertActionStyle.default,handler: doClearTheBoard ))
        alertController.addAction(UIAlertAction(title: "Clear Conflicting Entries", style: UIAlertActionStyle.default,handler: doClearConflicting ))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel,handler: nil))
        //alertController.preferredAction = alertController.actions[2]
        self.present(alertController, animated: true, completion: nil)
    }
    
    func doClearTheBoard(action: UIAlertAction) {
        //Use action.title
        let puzzle = appDelegate.sudoku
        puzzle?.clearBoard()
        puzzleView.setNeedsDisplay()
    }
    
    func doAbandonGame(action: UIAlertAction) {
        //Use action.title
        let puzzle = appDelegate.sudoku
        puzzle?.clearBoard()
        puzzle?.abandonGame()
        puzzleView.setNeedsDisplay()
        performSegue(withIdentifier: "goToMainView", sender: self)
    }
    
    func doClearConflicting(action: UIAlertAction) {
        //Use action.title
        let puzzle = appDelegate.sudoku
        puzzle?.clearConflictingCells()
        puzzleView.setNeedsDisplay()
    }
    
    
    @IBAction func pencilPressed(_ sender: UIButton) {
        pencilEnabled = !pencilEnabled
        sender.isSelected = pencilEnabled
        if (pencilEnabled){
            pencilButton.backgroundColor = UIColor.gray
        }
        else{
            pencilButton.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func digitPressed(_ sender: UIButton) {
        if !pencilEnabled {
            return
        }
        let value = sender.tag
        let puzzle = appDelegate.sudoku
        
        let row = puzzleView.selected.row
        let col = puzzleView.selected.column
        
        if row != -1 && col != -1 {
            if puzzle!.anyPencilSetAt(row: row, column: col) {
                if puzzle!.isSetPencil(value, row: row, column: col) {
                    puzzle?.clearNumberAt(row: row, column: col)
                }
                else{
                    puzzle?.setNumberAt(row: row, column: col, value: value)
                }
            }
            else {
                puzzle?.setNumberAt(row: row, column: col, value: value)
            }
        }
        
        if (puzzle!.checkForWin() ){
            let alertController = UIAlertController(title: "Congrats!", message: "you solved the game", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        
        puzzleView.setNeedsDisplay()
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        let puzzle = appDelegate.sudoku
        let row = puzzleView.selected.row
        let col = puzzleView.selected.column
        if (row == -1 || col == -1){
            return
        }
        puzzle?.clearNumberAt(row: row, column: col)
        
        sender.isSelected = false
        puzzleView.setNeedsDisplay()
    }
    @IBAction func abandonPressed(_ sender: Any) {
        //let puzzle = appDelegate.sudoku
        let alertController = UIAlertController(title: "Abandon Game", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "Abandon Game", style: UIAlertActionStyle.destructive,handler: doAbandonGame))
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
