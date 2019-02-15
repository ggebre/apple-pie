//
//  ViewController.swift
//  Apple Pie
//
//  Created by Getu Gebre on 2/14/19.
//  Copyright © 2019 Getu Gebre. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var listOfWords = ["doro wot", "noodles", "soccer", "reading", "dog", "cat", "television","dresser", "plates"]
    let incorrectMovesAllowed = 7
    
    var totalWins = 0
    var totalLoses = 0
    
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var treeImageView: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBOutlet var letterButtons: [UIButton]!
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        newRound()
    }
    func newRound (){
        
    }


}

