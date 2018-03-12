//
//  ViewController.swift
//  Example
//
//  Created by Ennio Masi on 11/03/2018.
//  Copyright © 2018 D-E. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var exampleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myText = "Hi Mate ثت yo"
        self.exampleLabel.attributedString(with: myText, on: [.arabic])
    }
}

