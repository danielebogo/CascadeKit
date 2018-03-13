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

        let attributed = NSMutableAttributedString(string: myText)
        attributed.addAttributes(for: [.latin]) {

            let colorAttribute = CascadeAttribute(key: .foregroundColor,
                                                  value: UIColor.red,
                                                  range: $0.range)

            let backgroundAttribute = CascadeAttribute(key: .backgroundColor,
                                                       value: UIColor.yellow,
                                                       range: $0.range)

            return [colorAttribute, backgroundAttribute]
        }

        self.exampleLabel.attributedText = attributed
    }
}

