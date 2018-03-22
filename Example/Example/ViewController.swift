//
//  ViewController.swift
//  Example
//
//  Created by Ennio Masi on 11/03/2018.
//  Copyright © 2018 D-E. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var example01: UILabel!
    @IBOutlet weak var example02: UILabel!
    @IBOutlet weak var example03: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ---------------------------------------------------------------
        let myText1 = "Hi Mate ثت yo"

        let attributed1 = NSMutableAttributedString(string: myText1)
        attributed1.addAttributes(for: [.latin]) {

            self.applyAttributes(fallback: $0)
        }

        self.example01.attributedText = attributed1
        // ---------------------------------------------------------------

        // ---------------------------------------------------------------
        let myText2 = "Л A ю BдиC го"

        let attributed2 = NSMutableAttributedString(string: myText2)
        attributed2.addAttributes(for: [.latin]) {

            self.applyAttributes(fallback: $0)
        }

        self.example02.attributedText = attributed2
        // ---------------------------------------------------------------

        // ---------------------------------------------------------------
        let myText3 = "έν A α δ BBB οκίμιο κCCCCαι ανακάτεψε"

        let attributed3 = NSMutableAttributedString(string: myText3)
        attributed3.addAttributes(for: [.latin]) {

            self.applyAttributes(fallback: $0)
        }

        self.example03.attributedText = attributed2
        // ---------------------------------------------------------------
    }

    private func applyAttributes(fallback: CascadeFallback) -> [CascadeAttribute] {
        let colorAttribute = CascadeAttribute(key: .foregroundColor,
                                              value: UIColor.red,
                                              range: fallback.range)

        let backgroundAttribute = CascadeAttribute(key: .backgroundColor,
                                                   value: UIColor.yellow,
                                                   range: fallback.range)

        return [colorAttribute, backgroundAttribute]
    }
}

