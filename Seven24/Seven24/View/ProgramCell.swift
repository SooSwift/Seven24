//
//  ProgramCell.swift
//  Seven24
//
//  Created by Sachin Sawant on 15/01/17.
//  Copyright © 2017 Sachin Sawant. All rights reserved.
//

import UIKit

class ProgramCell: UITableViewCell {

    @IBOutlet weak var programName: UILabel!
    @IBOutlet weak var programStartTime: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
