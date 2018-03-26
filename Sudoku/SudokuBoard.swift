//
//  SudokuBoard.swift
//  Sudoku
//
//  Created by Daniil V Kernazhytski on 3/24/18.
//  Copyright © 2018 Daniil.Kerna. All rights reserved.
//

import Foundation

struct Cell {
    var value: Int
    var isFixed: Bool
    var isHaveValueWritten: Bool
    
    init(value: Int, isFixed: Bool, isHaveValueWritten: Bool){
        self.value = value
        self.isFixed = isFixed
        self.isHaveValueWritten = isHaveValueWritten
    }
}

class SudokuBoard{
    var board: [[Cell]] = Array(repeating: Array(repeating: Cell(value: 0, isFixed: true, isHaveValueWritten: false), count: 9), count: 9)
    
    init(puzzle: String){       //iniitailize the board
        var row = 0
        var col = 0
        for c in puzzle{
            if let value = Int(String(c)){
                self.board[row][col] = Cell(value: value, isFixed: true, isHaveValueWritten: false)
            }
            else{
                self.board[row][col] = Cell(value: 0, isFixed: false, isHaveValueWritten: false)
            }
            if (col == 8){
                row += 1
            }
            col = (col + 1) % 9
        }
    }
    
    func numberAt(row: Int, column: Int) -> Int {   // Number stored at given row and column, 0 indicates empty
        return self.board[row][column].value
    }
    
    func clearNumberAt(row: Int, column: Int) -> Void {//clear number at
        self.board[row][column].value = 0
        self.board[row][column].isHaveValueWritten = false
    }
    
    func setNumberAt(row: Int, column: Int , value: Int){
        self.board[row][column].value = value
        self.board[row][column].isHaveValueWritten = true
    }
    
    func clearBoard(){
        for row in 0 ..< 9 {
            for col in 0 ..< 9 {
                if (!self.numberIsFixedAt(row: row, column: col)) {
                    self.clearNumberAt(row: row, column: col)
                }
            }
        }
    }
    
    func clearConflictingCells(){
        for row in 0 ..< 9 {
            for col in 0 ..< 9 {
                if (self.anyPencilSetAt(row: row, column: col) && self.isConflictingEntryAt(row: row, column: col)) {
                    self.clearNumberAt(row: row, column: col)
                }
            }
        }
        
    }
    
    func numberIsFixedAt(row: Int, column: Int) -> Bool {     // is the number part of the puzzle and cannot be changed
        return self.board[row][column].isFixed
    }
    
    func isConflictingEntryAt(row :Int, column :Int) -> Bool { // Does the number conflict with any other
        var result: Bool
        result  = isConflictingRow(row: row, value: numberAt(row: row, column: column))
        result = result || isConflictingCol(col: column, value: numberAt(row: row, column: column))
        result = result || isConflictingGrid(row: row, col: column, value: numberAt(row: row, column: column))
        return result
    }
    
    func isConflictingRow(row :Int , value :Int ) -> Bool{      //does the row passed have more than one same value
        var count: Int = 0
        for col in 0 ..< 9 {
            if (numberAt(row: row, column: col) == value){
                count += 1
            }
        }
        if ( count == 1){
            return false
        }
        else {return true}
    }
    
    func isConflictingCol(col :Int , value :Int) -> Bool{       //does the column passed have more than one value
        var count: Int = 0
        for row in 0 ..< 9 {
            if (numberAt(row: row, column: col) == value){
                count += 1
            }
        }
        if ( count == 1){
            return false
        }
        else {return true}
        
    }
    
    func isConflictingGrid(row :Int, col :Int , value :Int) ->Bool {        //does the grid contain more than one value 
        var count: Int = 0
        let firstRow :Int = setFirstRowAndColumn(num: row)
        let firstCol :Int = setFirstRowAndColumn(num: col)
        for r in firstRow ..< firstRow+3 {
            for c in firstCol ..< firstCol+3 {
                if (numberAt(row: r, column: c) == value) {
                    count += 1
                }
            }
        }
        if ( count == 1){
            return false
        }
        else {return true}
    }
    
    func setFirstRowAndColumn(num :Int) -> Int {        //returns the first row or column of a given grid
        var result :Int
        if (num >= 6){
            result = num - (num % 6)
            return result
        }
        else if ( num >= 3){
            result = num - (num % 3)
            return result
        }
        else{
            return 0
        }
    }
    
    func anyPencilSetAt(row :Int, column :Int) -> Bool {    // Are there any penciled in values at the given cell
        return self.board[row][column].isHaveValueWritten
    }
    
    func isSetPencil(_ n : Int, row :Int, column :Int) -> Bool { //Is value n penciled in ?
        return (n == numberAt(row: row, column: column))
    }
}

