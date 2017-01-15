//
//  ProgramDetailViewController.swift
//  Seven24
//
//  Created by Sachin Sawant on 15/01/17.
//  Copyright © 2017 Sachin Sawant. All rights reserved.
//

import UIKit

class ProgramDetailViewController: UIViewController {
    
    // MARK:- Properties
    @IBOutlet weak var programDate: UILabel!
    @IBOutlet weak var ratingBar: UISegmentedControl!
    @IBOutlet weak var userRating: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var programName: UILabel!
    
    var channelId:NSInteger = -1
    var program:Program = Program(id: -1, name: "", startTime: Date(), endtime: Date())
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.ratingBar.selectedSegmentIndex = UISegmentedControlNoSegment
        self.userRating.text = "Not Available"
        self.setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK:- Private Methods
    func setupViews() {
        // Load cached rating
        let cachedRating:Rating = RatingManager.sharedInstance.getRatingFor(channel: channelId, program: self.program.id)
        self.userRating.text = cachedRating.description
        print("Cached rating : \(cachedRating.rawValue)")
        self.ratingBar.selectedSegmentIndex = (cachedRating.rawValue - 1)
        
        self.programName.text = self.program.name
        self.programDate.text = self.program.startTime?.getWeekdayAndDayString() ?? "Not available"
        self.startTime.text = self.program.startTime?.get12HourTime() ?? "Not available"
        self.endTime.text = self.program.endtime?.get12HourTime() ?? "Not available"
    }
    
    // MARK:- Segment Control Menthods
    @IBAction func onRatingChanged(_ sender: Any) {
        let index = self.ratingBar.selectedSegmentIndex;
        self.userRating.text = Rating(rawValue: index+1)?.description ?? "Not Available"
    }
    
    // Mark:- Save Action
    @IBAction func onSaveRatings(_ sender: Any) {
        let rating = Rating(rawValue: self.ratingBar.selectedSegmentIndex + 1) ?? Rating.NotAvailable
        RatingManager.sharedInstance.setRating(rating: rating, forChannel: channelId, program: self.program.id)
    }
    
}
