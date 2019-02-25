//
//  SettingsViewController.swift
//  Weathertime
//
//  Created by Sriteja Thuraka on 4/28/18.
//  Copyright © 2018 Sriteja Thuraka. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "privacyCell", for: indexPath)
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "licenseCell", for: indexPath)
            return cell
        }
       return UITableViewCell()
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "privacyCell" {
            let destinationController = segue.destination as! PrivacyViewController
                destinationController.textMatter = WeatherDataManager.sharedInstance.privacy
        }
    }
  
 
}
