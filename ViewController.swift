//
//  ViewController.swift
//  ActionSheet
//
//  Created by Apple on 29/08/19.
//  Copyright © 2019 Revolut. All rights reserved.
//

import UIKit

// MARK: - Welcome
struct Welcome: Codable {
    let status: Bool
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let agid, teamid, genname, dataDescription: String
    let schools: [School]
    let games, reminder: [String]
    
    enum CodingKeys: String, CodingKey {
        case agid, teamid, genname
        case dataDescription = "description"
        case schools, games, reminder
    }
}

// MARK: - School
struct School: Codable {
    let name, team: String
}

class ViewController: UIViewController {

    @IBOutlet weak var resultButton: UIButton!
    var schoolsData = [School]()
    var filteredSec = [DataClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadJSON()
    }
    
    // MARK: JSON Data Load
    
    func loadJSON(){
        let urlPath = ""
        let url = NSURL(string: urlPath)
        let session = URLSession.shared
        let task = session.dataTask(with: url! as URL) { data, response, error in
            guard data != nil && error == nil else {
                print(error!.localizedDescription)
                return
            }
            do {
                let decoder = try JSONDecoder().decode(Welcome.self,  from: data!)
                let status = decoder.status
                if status == true {
                    self.schoolsData = decoder.data.schools
                    self.filteredSec = [decoder.data] // Getting Error Here
                    DispatchQueue.main.async {
                        //self.tableView.reloadData()
                    }
                } else {
                    
                }
            } catch { print(error) }
        }
        task.resume()
    }
    
    @IBAction func ClickAction(_ sender: Any) {
        
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheetAlertController.addAction(cancelActionButton)
        
        // Button #1
        let oneActionButton = UIAlertAction(title: "One", style: .default, handler: {(action:UIAlertAction!) in
            print("One")
        })
        oneActionButton.setValue(#imageLiteral(resourceName: "usa.png"), forKey: "image")
        oneActionButton.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        // Button #2
        let twoActionButton = UIAlertAction(title: "Two", style: .default, handler:{(action:UIAlertAction!) in
            print("Two")
        })
        twoActionButton.setValue(#imageLiteral(resourceName: "usa.png"), forKey: "image")
        twoActionButton.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        // Button #3
        let threeActionButton = UIAlertAction(title: "Three", style: .default, handler:{(action:UIAlertAction!) in
            print("Three")
        })
        threeActionButton.setValue(#imageLiteral(resourceName: "usa.png"), forKey: "image")
        threeActionButton.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        // Button #4
        let fourActionButton = UIAlertAction(title: "Four", style: .default, handler:{(action:UIAlertAction!) in
            print("Four")
        })
        fourActionButton.setValue(#imageLiteral(resourceName: "usa.png"), forKey: "image")
        fourActionButton.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        actionSheetAlertController.view.tintColor = #colorLiteral(red: 0.317096545, green: 0.5791940689, blue: 0.3803742655, alpha: 1)
        
        let index = self.filteredSec[0].agid

        switch index {
        case "18"  :
        // Show Actionsheet button 1 & 2
        actionSheetAlertController.addAction(oneActionButton)
        actionSheetAlertController.addAction(twoActionButton)
        case "188"  :
        // Show Actionsheet button 4
        actionSheetAlertController.addAction(fourActionButton)
        case "5"  :
        // Show Actionsheet button 3
        actionSheetAlertController.addAction(threeActionButton)
        default :
        // Show Actionsheet button 1 & 3
        actionSheetAlertController.addAction(oneActionButton)
        actionSheetAlertController.addAction(threeActionButton)
        }
        
        self.present(actionSheetAlertController, animated: true, completion: nil)
    }
}

