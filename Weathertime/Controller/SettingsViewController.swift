//
//  SettingsViewController.swift
//  Weathertime
//
//  Created by Sriteja Thuraka on 4/28/18.
//  Copyright © 2018 Sriteja Thuraka. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "privacyCell", for: indexPath)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "licensesCell", for: indexPath)
            return cell
        default:
            break
        }
        return UITableViewCell()
    }

}
