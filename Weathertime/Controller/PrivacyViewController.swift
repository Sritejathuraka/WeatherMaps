//
//  PrivacyViewController.swift
//  Weathertime
//
//  Created by Sriteja Thuraka on 4/30/18.
//  Copyright © 2018 Sriteja Thuraka. All rights reserved.
//

import UIKit

class PrivacyViewController: UIViewController {
    @IBOutlet var textView: UITextView!
    var textMatter: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textView.text = textMatter
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
