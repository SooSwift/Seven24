//
//  ProgramViewController.swift
//  Seven24
//
//  Created by Sachin Sawant on 15/01/17.
//  Copyright © 2017 Sachin Sawant. All rights reserved.
//

import UIKit

class ProgramViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var programsTableView: UITableView!
    var channel:Channel = Channel(id: 0, name: "", displayOrder: 0, programs: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = channel.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- TableView DataSource and Delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channel.programs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProgramCell") as! ProgramCell
        
        let program = self.channel.programs[indexPath.row]
        cell.programName.text = program.name
        if let startTime = program.startTime {
            cell.programStartTime.text = String(format: "Starts %@", startTime.getDayAndTimeString())
        } else {
            cell.programStartTime.text = "Start-time not available"
        }
        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
