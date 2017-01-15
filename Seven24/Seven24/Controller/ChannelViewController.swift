//
//  ChannelViewController.swift
//  Seven24
//
//  Created by Sachin Sawant on 14/01/17.
//  Copyright © 2017 Sachin Sawant. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK:- Properties
    @IBOutlet weak var channelTableView: UITableView!
    var channelGuide:ChannelGuide = ChannelGuide(channels:[])
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = true
        //Add footerView to hide empty cells
        self.channelTableView.tableFooterView = UIView()
        self.getChannelGuideFromFeed();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- TableView DataSource and Delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channelGuide.channels.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelCell") as! ChannelCell
        
        let channel = channelGuide.channels[indexPath.row]
        cell.channelName.text = channel.name
        cell.channelDescription.text = String(format: "%d programs scheduled ", channel.programs.count)
        
        return cell
    }
    
    // MARK:- Private methods
    private func getChannelGuideFromFeed() {
        self.showProgressIndicator()
        let channelGuideManager = ChannelGuideManager();
        channelGuideManager.getChannelGuide(fromURLString: Config.channelGuideServiceURL) { (success, channelGuide) in
            
            // Show alert to user on failure
            if(!success || channelGuide == nil) {
                DispatchQueue.main.async {
                    self.hideProgressIndicator()
                    let alert = UIAlertController(title: "Error", message: "Unable to fetch channel guide", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
            guard let channelGuide = channelGuide else {
                return
            }
            
            // Success
            self.channelGuide = channelGuide
            self.channelGuide.sort();
            
            DispatchQueue.main.async {
                self.hideProgressIndicator()
                self.channelTableView.reloadData()
            }
        }
    }
    
    //MARK:- Activity Indicator methods
    func showProgressIndicator() {
        self.activityIndicator.startAnimating()
        self.activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
    }
    
    func hideProgressIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.removeFromSuperview()
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "showPrograms":
            guard let programViewController:ProgramViewController = segue.destination as? ProgramViewController else {
                return
            }
            guard let selectedChannel = self.channelTableView.indexPathForSelectedRow?.row else {
                return
            }
            programViewController.channel = self.channelGuide.channels[selectedChannel]
            
        default:
            return;
        }
    }
}
