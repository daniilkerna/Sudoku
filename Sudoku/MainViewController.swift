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
    @IBOutlet weak var contineButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func newEasyGamePressed(_ sender: Any) {
        let puzzle = appDelegate.selectRandomPuzzle(puzzles: appDelegate.simplePuzzles)
        appDelegate.sudoku = SudokuBoard(puzzle: puzzle)
        performSegue(withIdentifier: "goToGameWithSegue", sender: self)
        
    }
    
    @IBAction func newHardGamePressed(_ sender: Any) {
        let puzzle = appDelegate.selectRandomPuzzle(puzzles: appDelegate.hardPuzzles)
        appDelegate.sudoku = SudokuBoard(puzzle: puzzle)
        performSegue(withIdentifier: "goToGameWithSegue", sender: self)
    }
    
}

