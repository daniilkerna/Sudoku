//
//  MainViewController.swift
//  Sudoku
//
//  Created by Daniil K on 3/20/18.
//  Copyright © 2018 Daniil K. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var puzzle : String = ""
    @IBOutlet weak var contineButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        if (puzzle.isEmpty){
            contineButton.isEnabled = false
            contineButton.isHidden = true
        }
        else{
            
            if (appDelegate.sudoku!.gameIsOn){
                contineButton.isEnabled = true
                contineButton.isHidden = false
            }
            else{
                contineButton.isEnabled = false
                contineButton.isHidden = true
            }
        }
        //self.navigationController?.setToolbarHidden(true, animated: true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func newEasyGamePressed(_ sender: Any) {
        if (puzzle.isEmpty){
            puzzle = appDelegate.selectRandomPuzzle(puzzles: appDelegate.simplePuzzles)
            appDelegate.sudoku = SudokuBoard(puzzle: puzzle)
            performSegue(withIdentifier: "goToGameWithSegue", sender: self)
        }
        else{
            if (appDelegate.sudoku!.gameIsOn){
                let alertController = UIAlertController(title: "Game In progress", message: "Start New Game?", preferredStyle: UIAlertControllerStyle.alert)
                
                alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.destructive,handler: getEasyGame ))
                alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default,handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
            else{
            puzzle = appDelegate.selectRandomPuzzle(puzzles: appDelegate.simplePuzzles)
            appDelegate.sudoku = SudokuBoard(puzzle: puzzle)
            performSegue(withIdentifier: "goToGameWithSegue", sender: self)
            }
        }
        
    }
    
    @IBAction func newHardGamePressed(_ sender: Any) {
        if (puzzle.isEmpty){
            puzzle = appDelegate.selectRandomPuzzle(puzzles: appDelegate.hardPuzzles)
            appDelegate.sudoku = SudokuBoard(puzzle: puzzle)
            performSegue(withIdentifier: "goToGameWithSegue", sender: self)
        }
        else{
            if (appDelegate.sudoku!.gameIsOn){
                let alertController = UIAlertController(title: "Game In progress", message: "Start New Game?", preferredStyle: UIAlertControllerStyle.alert)
                
                alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.destructive,handler: getHardGame ))
                alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default,handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
            else{
            puzzle = appDelegate.selectRandomPuzzle(puzzles: appDelegate.hardPuzzles)
            appDelegate.sudoku = SudokuBoard(puzzle: puzzle)
            performSegue(withIdentifier: "goToGameWithSegue", sender: self)
            }
        }
    }
    
    @IBAction func continuePressed(_ sender: Any) {
        performSegue(withIdentifier: "goToGameWithSegue", sender: self)
    }
    func getHardGame(action: UIAlertAction){
        puzzle = appDelegate.selectRandomPuzzle(puzzles: appDelegate.hardPuzzles)
        appDelegate.sudoku = SudokuBoard(puzzle: puzzle)
        performSegue(withIdentifier: "goToGameWithSegue", sender: self)
    }
    func getEasyGame(action: UIAlertAction){
        puzzle = appDelegate.selectRandomPuzzle(puzzles: appDelegate.simplePuzzles)
        appDelegate.sudoku = SudokuBoard(puzzle: puzzle)
        performSegue(withIdentifier: "goToGameWithSegue", sender: self)
    }
}

